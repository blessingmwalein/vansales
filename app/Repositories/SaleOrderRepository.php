<?php

namespace App\Repositories;

use App\Interfaces\LoadSheetRepositoryInterface;
use App\Interfaces\SaleOrderRepositoryInterface;
use App\Jobs\BulkSyncSalesOrders;
use App\Models\Currency;
use App\Models\Customer;
use App\Models\Loadsheet;
use App\Models\SaleOrder;

class SaleOrderRepository implements SaleOrderRepositoryInterface
{
    private LoadSheetRepositoryInterface $loadSheetRepository;

    public function __construct(LoadSheetRepositoryInterface $loadSheetRepository)
    {
        $this->loadSheetRepository = $loadSheetRepository;
    }

    //sync sale order bulk
    public function syncSaleOrderBulk(array $data)
    {
        // dispatch(new BulkSyncSalesOrders($data))->onQueue('bulk_sync');
        $job = new BulkSyncSalesOrders($data);
        $job->handle();
        $this->loadSheetRepository->createLoadSheetHistory($data[0]['loadsheet_id'], 'Synced', 'Loadsheet Sales Synced');
        return true;
    }

    //sync sale order individual
    public function syncSaleOrderIndividual(array $data)
    {
    }

    public function getPaginated($perPage = 10)
    {
        return SaleOrder::latest()->paginate($perPage);
    }

    public function getSaleOrderDetails($id, $page = 10)
    {
    
        $saleOrder = SaleOrder::find($id);
        return $saleOrder->salesOrderDetails()->paginate($page);
    }

    public function show($id)
    {
        return SaleOrder::find($id);
    }

    public function filter($customer, $status, $from, $to, $paymentMethod, $order_number, $currency, $loadsheet)
    {
        $query = SaleOrder::query();
        if ($customer) {
            $customerIds = Customer::where('name', 'like', '%' . $customer . '%')->pluck('id')->toArray();
            //use where in to search for customer ids
            $query->whereIn('customer_id', $customerIds);
        }
        if ($status) {
            $query->whereIn('status', $status);
        }
        if ($from && $to) {
            $query->whereBetween('created_at', [$from, $to]);
        }
        if ($paymentMethod) {
            //use like to search for payment method
            $query->where('payment_method', 'like', '%' . $paymentMethod . '%');
        }
        if ($order_number) {
            $query->where('order_number', $order_number);
        }
        if ($currency) {
            $query->whereIn('currency_id', $currency);
        }
        if ($loadsheet) {
            $findLoadByNumber = Loadsheet::where('loadsheet_number', $loadsheet)->first();
            $query->where('loadsheet_id', $findLoadByNumber->id);
        }
        return $query->latest()->paginate(10);
    }
}
