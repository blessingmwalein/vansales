<?php

namespace App\Repositories;

use App\Interfaces\CustomerRepositoryInterface;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\InvoiceRepositoryInterface;
use App\Interfaces\LoadSheetRepositoryInterface;
use App\Interfaces\PricingMethodRepositoryInterface;
use App\Models\Customer;
use App\Models\CustomerStop;
use App\Models\Delivery;
use App\Models\DeliveryHistory;
use App\Models\DeliveryItem;
use App\Models\DeliverySheet;
use App\Models\Invoice;
use App\Models\InvoiceItem;
use App\Models\Loadsheet;
use App\Models\LoadSheetDetail;
use App\Models\SaleOrder;
use App\Models\Stock;
use App\Models\Truck;
use App\Models\User;

class InvoiceRepository implements InvoiceRepositoryInterface
{
    private GeneralSettingRepositoryInterface $generalSettingRepository;
    private CustomerRepositoryInterface $customerRepository;
    private PricingMethodRepositoryInterface $pricingMethodRepository;
    private LoadSheetRepositoryInterface $loadSheetRepositoryInterface;

    public function __construct(
        GeneralSettingRepositoryInterface $generalSettingRepository,
        CustomerRepositoryInterface $customerRepository,
        PricingMethodRepositoryInterface $pricingMethodRepository,
        LoadSheetRepositoryInterface $loadSheetRepositoryInterface
    ) {
        $this->generalSettingRepository = $generalSettingRepository;
        $this->customerRepository = $customerRepository;
        $this->pricingMethodRepository = $pricingMethodRepository;
        $this->loadSheetRepositoryInterface = $loadSheetRepositoryInterface;
    }

    public function all()
    {
        return Invoice::all();
    }

    public function getPaginated(int $n)
    {
        return Invoice::where('company_id', auth()->user()->company_id)->paginate($n);
    }

    public function syncInvoices(array $default,  array $invoices)
    {

        foreach ($invoices as $key => $invoice) {
            // dd($invoice);
            if ($this->isSyncedInvoice($invoice['invoice_number'])) {
                continue;
            }

            $newInvoice = Invoice::create([
                'invoice_number' => $invoice['invoice_number'],
                'status' => $invoice['status'],
                'totals' => json_encode($invoice['totals']),
                'tax' => json_encode($invoice['tax']),
                'discount' => json_encode($invoice['discount']),
                'type' => $default['type'],
                'delivery_id' => isset($invoice['delivery_id']) ? $invoice['delivery_id'] : null,
                'delivery_sheet_id' => isset($default['delivery_sheet_id']) ? $default['delivery_sheet_id'] : null,
                'loadsheet_id' => isset($default['loadsheet_id']) ? $default['loadsheet_id'] : null,
                'customer_id' => $invoice['customer_id'],
                'branch_id' => isset($default['branch_id'])  ? $default['branch_id'] : null,
            ]);

            $invoiceItems = $invoice['items'];

            foreach ($invoiceItems as $key => $item) {
                if ($this->isInvoiceItemSynced($invoice['invoice_number'], $item['stock_id'])) {
                    continue;
                }
                InvoiceItem::create([
                    'stock_id' => $item['stock_id'],
                    'quantity' => $item['quantity'],
                    "invoice_id" => $newInvoice->id,
                    'is_synced' => true,
                ]);
            }
        }

        return true;
    }

    public function isSyncedInvoice($invoiceNumber)
    {
        $invoice = Invoice::where('invoice_number', $invoiceNumber)->first();
        if ($invoice) {
            return true;
        }
        return false;
    }

    public function isInvoiceItemSynced($invoiceNumber, $stockId)
    {
        $invoice = Invoice::where('invoice_number', $invoiceNumber)->first();
        if ($invoice) {
            $invoiceItem = $invoice->items()->where('stock_id', $stockId)->first();
            if ($invoiceItem) {
                return true;
            }
        }
        return false;
    }

    public function filter($customer, $status, $type, $from, $to, $invoice_number, $delivery, $loadsheet, $branch)
    {
        $query = Invoice::query();

        if ($type) {
            $query->where('type', $type);
        }
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
        // if ($paymentMethod) {
        //     //use like to search for payment method
        //     $query->where('payment_method', 'like', '%' . $paymentMethod . '%');
        // }
        if ($invoice_number) {
            $query->where('invoice_number', $invoice_number);
        }
        if ($loadsheet) {
            $findLoadByNumber = Loadsheet::where('loadsheet_number', $loadsheet)->first();
            $query->where('loadsheet_id', $findLoadByNumber->id);
        }

        if ($delivery) {
            $findDeliveryByNumber = DeliverySheet::where('delivery_sheet_number', $delivery)->first();
            $query->where('delivery_sheet_id', $findDeliveryByNumber->id);
        }

        if ($branch) {
            $query->where('branch_id', $branch);
        }


        return $query->latest()->paginate(10);
    }

    public function companyTotalIncome($from = null, $to = null)
    {
        $query = Invoice::query();
        if ($from && $to) {
            $query->whereBetween('created_at', [$from, $to]);
        }
        $invoices = $query->where('company_id', auth()->user()->company_id)->get();
        $total = 0;
        foreach ($invoices as $key => $invoice) {
            $items  = $invoice->items;
            foreach ($items as $key => $item) {
                if ($item->stock && $item->stock->product && $item->stock->product->getDefaultPrice()) {
                    $total += $item->stock->product->getDefaultPrice()->retail_price * $item->quantity;
                } else {
                    // Handle the case where any part of the chain is null
                    // For example, set $total to 0 or display an error message
                    $total = 0;
                    // echo "Error: Unable to calculate total due to missing data.";
                }
                // $total += $item->stock->product->getDefaultPrice()->retail_price * $item->quantity;
            }
        }
        return $total;
    }

    public function companyInvoices($from = null, $to = null)
    {
        $query = Invoice::query();
        if ($from && $to) {
            $query->whereBetween('created_at', [$from, $to]);
        }
        return $query->where('company_id', auth()->user()->company_id)->get();
    }
}
