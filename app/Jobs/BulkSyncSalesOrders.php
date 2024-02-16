<?php

namespace App\Jobs;

use App\Models\SaleOrder;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class BulkSyncSalesOrders implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $salesOrders;

    public function __construct($salesOrders)
    {
        $this->salesOrders = $salesOrders;
    }

    public function handle()
    {
        foreach ($this->salesOrders as $salesOrderData) {
            // Check if the sale order is already synced
            if ($this->isSalesOrderSynced($salesOrderData['order_number'])) {
                continue; // Skip this sale order, it's already synced
            }

            // Create a new sale order
            $createdSalesOrder = SaleOrder::create([
                'order_number' => $salesOrderData['order_number'],
                'customer_id' => $salesOrderData['customer_id'] == 0 ? null : $salesOrderData['customer_id'],
                'loadsheet_id' => $salesOrderData['loadsheet_id'],
                'status' => $salesOrderData['status'],
                // 'payment_method' => $salesOrderData['payment_method'],
                // 'currency_id' => $salesOrderData['currency_id'],
                'discount' => json_encode($salesOrderData['discount']),
                'tax' => json_encode($salesOrderData['tax']),
                // 'total' => $salesOrderData['total'],
                'totals' => json_encode($salesOrderData['totals']),
            ]);

            $salesOrderDetails = $salesOrderData['salesOrderDetails'];

            // Save sale order details
            foreach ($salesOrderDetails as $salesOrderDetail) {
                // Check if the sale order detail is already synced
                if ($this->isSalesOrderDetailSynced($salesOrderData['order_number'], $salesOrderDetail['stock_id'])) {
                    continue; // Skip this sale order detail, it's already synced
                }

                $createdSalesOrder->salesOrderDetails()->create([
                    'stock_id' => $salesOrderDetail['stock_id'],
                    'quantity' => $salesOrderDetail['quantity'],
                    // 'total_price' => $salesOrderDetail['total_price'],
                    'is_synced' => true,
                ]);

                // Increment total items synced
                // $createdSalesOrder->increment('total_items_synced');
            }
        }
    }

    //check is sales order already synced
    public function isSalesOrderSynced($order_number)
    {
        $salesOrder = SaleOrder::where('order_number', $order_number)->first();
        if ($salesOrder) {
            return true;
        }
        return false;
    }

    //check is sales order detail already synced
    public function isSalesOrderDetailSynced($order_number, $stock_id)
    {
        $salesOrder = SaleOrder::where('order_number', $order_number)->first();
        if ($salesOrder) {
            $salesOrderDetail = $salesOrder->salesOrderDetails()->where('stock_id', $stock_id)->first();
            if ($salesOrderDetail) {
                return true;
            }
        }
        return false;
    }
}
