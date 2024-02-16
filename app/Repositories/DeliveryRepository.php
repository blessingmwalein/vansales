<?php

namespace App\Repositories;

use App\Interfaces\CustomerRepositoryInterface;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\DeliveryRepositoryInterface;
use App\Interfaces\LoadSheetRepositoryInterface;
use App\Interfaces\PricingMethodRepositoryInterface;
use App\Models\CustomerStop;
use App\Models\Delivery;
use App\Models\DeliveryHistory;
use App\Models\DeliveryInvoice;
use App\Models\DeliveryInvoiceItem;
use App\Models\DeliveryItem;
use App\Models\DeliverySheet;
use App\Models\LoadSheetDetail;
use App\Models\SaleOrder;
use App\Models\Stock;
use App\Models\Truck;
use App\Models\User;

class DeliveryRepository implements DeliveryRepositoryInterface
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
        return DeliverySheet::all();
    }

    public function create(array $data)
    {
        $record = DeliverySheet::create($data);
        $record->setStatus('Created');
        $this->createDeliverySheetHistory($record->id, 'Created', 'Delivery Sheet Created');
        $record->truck->update(['is_available' => false]);

        $this->generalSettingRepository->checkIfSettingIsActivated('Deliveries')
            ? null :
            $record->driver->update(['is_available' => false]);
        // $this->assignDeliveries($record);

        return $record;
    }


    public function update(array $data, $id)
    {
        $record = DeliverySheet::find($id);


        //update truck is_available to false
        if ($record->truck_id == $data['truck_id']) {
            $record->truck->update(['is_available' => false]);
        } else {
            $oldTruck = $record->truck;
            $oldTruck->update(['is_available' => true]);
            $newTruck = Truck::find($data['truck_id']);
            $newTruck->update(['is_available' => false]);
        }
        $record->update($data);
        $this->createDeliverySheetHistory($id, 'Updated', 'DeliverySheet Updated Changes:' . json_encode($record->getChanges()));
        return $record;
    }

    public function delete($id)
    {
        $sheet = DeliverySheet::find($id);
        //update truck is_available to true
        $sheet->truck->update(['is_available' => true]);
        $sheet->setStatus('Cancelled');

        $this->createDeliverySheetHistory($id, 'Cancelled', 'DeliverySheet Cancelled');
        $sheet->user->update(['is_available' => true]);

        return $sheet;
    }

    public function show($id)
    {
        return DeliverySheet::find($id);
    }

    public function getPaginated($perPage = 10)
    {

        //sort by latest

        return DeliverySheet::latest()->paginate($perPage);
    }



    public function filter($driver, $truck, $route, $warehouse, $status, $from, $to)
    {
        $query = DeliverySheet::query();
        if ($driver) {
            $query->whereIn('user_id', $driver);
        }
        if ($truck) {
            $query->whereIn('truck_id', $truck);
        }
        if ($route) {
            $query->whereIn('route_id', $route);
        }
        if ($warehouse) {
            $query->whereIn('warehouse_id', $warehouse);
        }
        if ($status) {
            //status is an array of statuses like ["Loaded","Created"]
            $query->whereIn('status', $status);
        }
        if ($from && $to) {
            $query->whereBetween('created_at', [$from, $to]);
        }
        return $query->paginate(10);
    }

    public function createDeliverySheetHistory($id, $status, $description)
    {

        // dd($deliverySheet);
        DeliveryHistory::create([
            'user_id' => auth()->user()->id,
            'status' => $status,
            'description' => $description,
            'delivery_sheet_id' => $id
        ]);
        return true;
    }

    // public function assignDeliveries($deliverySheet)
    // {
    //     $route = $deliverySheet->route;
    //     foreach ($route->customers as $key => $value) {
    //         $deliverySheet->deliveries()->create([
    //             'customer_id' => $value->id,
    //         ]);
    //     }
    //     $this->createDeliverySheetHistory($loadsheet->id, 'Deliveries Added', 'Deliveries Added');
    //     return true;
    // }

    public function confirmDeliverySheet($id)
    {
        $deliverySheet = DeliverySheet::find($id);
        $deliverySheet->setStatus('Confirmed');
        $this->createDeliverySheetHistory($id, 'Confirmed', 'DeliverySheet Confirmed');
        return $deliverySheet;
    }

    public function completeDeliverySheet($id)
    {
        $deliverySheet = DeliverySheet::find($id);
        $deliverySheet->setStatus('Completed');
        $this->createDeliverySheetHistory($id, 'Completed', 'DeliverySheet Completed');
        $deliverySheet->truck->update(['is_available' => true]);
        $deliverySheet->driver->update(['is_available' => true]);
        return $deliverySheet;
    }

    public function startDeliverySheet($id)
    {
        $deliverySheet = DeliverySheet::find($id);
        $deliverySheet->setStatus('Started');
        $this->createDeliverySheetHistory($id, 'Started', 'DeliverySheet Started');
        return $deliverySheet;
    }

    public function addDelivery($id, array $data)
    {
        $deliverySheet = DeliverySheet::find($id);

        $delivery = Delivery::create([
            'customer_id' => $data['customer_id'],
            'delivery_sheet_id' => $id,
            'status' => 'Pending'
        ]);

        // dd($delivery);
        foreach ($data['items'] as $key => $value) {
            // dd($value[$key]);
            $this->updateStock($value['stock_id'], $delivery->id, $value['quantity'], true);
        }

        $this->createDeliverySheetHistory($id, 'Delivery Added', 'Delivery Added');
        return $delivery;
    }

    public function updateStock($stock_id, $delivery_id, $quantity, $increment = false)
    {
        $detail = DeliveryItem::where('delivery_id', $delivery_id)->where('stock_id', $stock_id)->first();

        $delivery = Delivery::find($delivery_id);

        // dd($delivery_id);

        $sheet = DeliverySheet::find($delivery->delivery_sheet_id);
        // dd($stock_id, $delivery_sheet_id, $quantity, $isNew, $stock);
        if ($detail) {
            if ($increment) {
                $this->loadSheetRepositoryInterface->removeStockFromWarehouse($sheet->warehouse_id, $stock_id, $quantity);
            } else {
                if ($quantity > $detail->quantity) {
                    $this->loadSheetRepositoryInterface->removeStockFromWarehouse($sheet->warehouse_id, $stock_id, $quantity - $detail->quantity);
                } else {
                    $this->loadSheetRepositoryInterface->addStockToWarehouse($delivery->warehouse_id, $stock_id, $detail->quantity - $quantity);
                }
            }
            $detail->quantity = $increment ?  $quantity + $detail->quantity : $quantity;
            $detail->save();
        } else {
            $this->loadSheetRepositoryInterface->removeStockFromWarehouse($sheet->warehouse_id, $stock_id, $quantity);
            DeliveryItem::create([
                'stock_id' => $stock_id,
                'quantity' => $quantity,
                'delivery_id' => $delivery_id
            ]);
        }
        return true;
    }

    public function getDeliverySheetsByStatus($status)
    {
        $driver = auth()->user();

        return DeliverySheet::where('status', $status)->where('user_id', $driver->id)->get();
    }

    public function syncInvoices($id, array $invoices)
    {
        $delivery = Delivery::find($id);

        foreach ($invoices as $key => $invoice) {
            // dd($invoice);
            if ($this->isSyncedInvoice($invoice['invoice_number'])) {
                continue;
            }

            $newInvoice = DeliveryInvoice::create([
                'delivery_id' => $delivery->id,
                'delivery_sheet_id' => $delivery->delivery_sheet_id,
                'invoice_number' => $invoice['invoice_number'],
                'status' => $invoice['status'],
                'totals' => json_encode($invoice['totals']),
                'tax' => json_encode($invoice['tax']),
                'discount' => json_encode($invoice['discount']),
            ]);

            $invoiceItems = $invoice['items'];

            foreach ($invoiceItems as $key => $item) {
                if ($this->isInvoiceItemSynced($invoice['invoice_number'], $item['stock_id'])) {
                    continue;
                }
                DeliveryInvoiceItem::create([
                    'stock_id' => $item['stock_id'],
                    'quantity' => $item['quantity'],
                    "delivery_invoice_id" => $newInvoice->id,
                    // 'total_price' => $item['total_price'],
                    // 'currency_id' => $item['currency_id'],
                    'is_synced' => true,
                ]);
            }
        }

        return true;
    }

    public function isSyncedInvoice($invoiceNumber)
    {
        $invoice = DeliveryInvoice::where('invoice_number', $invoiceNumber)->first();
        if ($invoice) {
            return true;
        }
        return false;
    }

    public function isInvoiceItemSynced($invoiceNumber, $stockId)
    {
        $invoice = DeliveryInvoice::where('invoice_number', $invoiceNumber)->first();
        if ($invoice) {
            $invoiceItem = $invoice->items()->where('stock_id', $stockId)->first();
            if ($invoiceItem) {
                return true;
            }
        }
        return false;
    }

    public function getLoadSheetSummary($id)
    {

        // $sheet = DeliverySheet::find($id);
        // $totalAllocatedQuantity = $loadsheet->details()->sum('quantity');

        // //get loadsheet total inload quantity from sales order details through sales orders
        // $totalSoldQty = $loadsheet->orderDetails()->sum('quantity');

        // $totalSales = $loadsheet->orderDetails()->sum('total_price');

        // return [
        //     'total_allocated_quantity' => $totalAllocatedQuantity,
        //     'total_sold_quantity' => $totalSoldQty,
        //     'total_sales' => $totalSales,
        // ];
    }


}
