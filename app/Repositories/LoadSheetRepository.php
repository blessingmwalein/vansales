<?php

namespace App\Repositories;

use App\Interfaces\CustomerRepositoryInterface;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\LoadSheetRepositoryInterface;
use App\Interfaces\PricingMethodRepositoryInterface;
use App\Models\CustomerStop;
use App\Models\Loadsheet;
use App\Models\AllocationItem;
use App\Models\Stock;
use App\Models\Truck;
use App\Models\User;

class LoadSheetRepository implements LoadSheetRepositoryInterface
{
    private GeneralSettingRepositoryInterface $generalSettingRepository;
    private CustomerRepositoryInterface $customerRepository;
    private PricingMethodRepositoryInterface $pricingMethodRepository;

    public function __construct(GeneralSettingRepositoryInterface $generalSettingRepository, CustomerRepositoryInterface $customerRepository, PricingMethodRepositoryInterface $pricingMethodRepository)
    {
        $this->generalSettingRepository = $generalSettingRepository;
        $this->customerRepository = $customerRepository;
        $this->pricingMethodRepository = $pricingMethodRepository;
    }

    public function all()
    {
        return Loadsheet::all();
    }

    public function create(array $data)
    {
        //remove manual allocate from data and se to another variable
        $manualAllocate = $data['manual_allocate'];
        unset($data['manual_allocate']);

        $record = Loadsheet::create($data);

        $record->setStatus('Created');
        $this->createLoadSheetHistory($record->id, 'Created', 'Loadsheet Created');
        $record->truck->update(['is_available' => false]);

        $this->generalSettingRepository->checkIfSettingIsActivated('Loadsheets')
            ? null :
            $record->user->update(['is_available' => false]);
        $this->assignCustomerStopsForRoute($record);

        //add cash customer to customer stops
        $cashAccountCustomer = $this->customerRepository->getCashAccountCustomer();
        $cashAccountCustomer ? $record->customerStops()->create([
            'customer_id' => $cashAccountCustomer->id,
        ]) : null;

        if (!$manualAllocate) {
            $this->addAllAllocationFromWarehouse($record);
        }

        return $record;
    }

    public function assignCustomerStopsForRoute($loadsheet)
    {
        $route = $loadsheet->route;
        foreach ($route->customers as $key => $value) {
            $loadsheet->customerStops()->create([
                'customer_id' => $value->id,
            ]);
        }
        $this->createLoadSheetHistory($loadsheet->id, 'Customer Stops Added', 'Customer Stops Added');
        return true;
    }

    public function confirmLoadSheet($id)
    {
        $loadsheet = Loadsheet::find($id);
        $loadsheet->setStatus('Confirmed');
        $this->createLoadSheetHistory($id, 'Confirmed', 'Loadsheet Confirmed');
        return $loadsheet;
    }

    public function completeLoadSheet($id)
    {
        $loadsheet = Loadsheet::find($id);
        $loadsheet->setStatus('Completed');
        $this->createLoadSheetHistory($id, 'Completed', 'Loadsheet Completed');
        $loadsheet->user->update(['is_available' => true]);
        $loadsheet->truck->update(['is_available' => true]);

        return $loadsheet;
    }

    public function startLoadSheet($id)
    {
        $loadsheet = Loadsheet::find($id);
        $loadsheet->setStatus('Started');
        $this->createLoadSheetHistory($id, 'Started', 'Loadsheet Started');
        return $loadsheet;
    }

    public function update(array $data, $id)
    {
        $record = Loadsheet::find($id);


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
        $this->createLoadSheetHistory($id, 'Updated', 'Loadsheet Updated Changes:' . json_encode($record->getChanges()));
        return $record;
    }

    public function delete($id)
    {
        $sheet = Loadsheet::find($id);
        //update truck is_available to true
        $sheet->truck->update(['is_available' => true]);
        $sheet->setStatus('Cancelled');

        $this->createLoadSheetHistory($id, 'Cancelled', 'Loadsheet Cancelled');
        $sheet->user->update(['is_available' => true]);

        return $sheet;
    }

    public function show($id)
    {
        return Loadsheet::find($id);
    }

    public function getPaginated($perPage = 10)
    {

        //sort by latest

        return Loadsheet::latest()->paginate($perPage);
    }

    public function searchByLoadsheetNumber($search)
    {
        return Loadsheet::where('loadsheet_number', 'like', '%' . $search . '%')->paginate(10);
    }

    //filter loadsheet by status
    public function filterByStatus($status)
    {
        return Loadsheet::where('status', 'like', '%' . $status . '%')->paginate(10);
    }

    //search by date range
    public function searchByDateRange($from, $to)
    {
        return Loadsheet::whereBetween('created_at', [$from, $to])->paginate(10);
    }

    public function filter($driver, $truck, $route, $warehouse, $status, $from, $to)
    {
        $query = Loadsheet::query();
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

    public function addLoadSheetDetail($loadsheet_id, $data)
    {
        $loadsheet = Loadsheet::find($loadsheet_id);
        foreach ($data as $key => $value) {
            // dd($value[$key]);
            $this->updateStock($value['stock_id'], $loadsheet_id, $value['quantity'], true);
        }
        $loadsheet->setStatus('Loaded');
        $this->createLoadSheetHistory($loadsheet_id, 'Loaded', 'Loadsheet Loaded');
        return true;
    }

    public function addAllAllocationFromWarehouse($loadsheet)
    {
        $stocks = Stock::where('warehouse_id', $loadsheet->warehouse_id)->get();
        foreach ($stocks as $key => $value) {
            $this->updateStock($value->id, $loadsheet->id, $value->quantity, true);
        }
        $loadsheet->setStatus('Loaded');
        $this->createLoadSheetHistory($loadsheet->id, 'Loaded', 'Loadsheet Loaded');
        return true;
    }

    public function updateLoadSheetDetail($detail_id, $data)
    {

        $record = AllocationItem::find($detail_id);
        $update = $this->updateStock($record->stock_id, $record->load_sheet_id, $data['quantity'], false);
        $this->createLoadSheetHistory($record->load_sheet_id, 'Stock Updated', 'Stock Updated');
        return true;
    }

    public function deleteLoadSheetDetail($detail_id)
    {
        $record = AllocationItem::find($detail_id);
        $this->addStockToWarehouse($record->loadsheet->warehouse_id, $record->stock_id, $record->quantity);
        $record->delete();
        $loadsheet = Loadsheet::find($record->load_sheet_id);
        $this->createLoadSheetHistory($record->load_sheet_id, 'Deleted', 'Detail With Stock ID ' . $record->stock_id . ' Deleted');
        return true;
    }

    public function updateStock($stock_id, $load_sheet_id, $quantity, $increment = false)
    {
        $detail = AllocationItem::where('loadsheet_id', $load_sheet_id)->where('stock_id', $stock_id)->first();

        $loadsheet = Loadsheet::find($load_sheet_id);
        // dd($stock_id, $load_sheet_id, $quantity, $isNew, $stock);
        if ($detail) {
            if ($increment) {
                $this->removeStockFromWarehouse($loadsheet->warehouse_id, $stock_id, $quantity);
            } else {
                if ($quantity > $detail->quantity) {
                    $this->removeStockFromWarehouse($loadsheet->warehouse_id, $stock_id, $quantity - $detail->quantity);
                } else {
                    $this->addStockToWarehouse($loadsheet->warehouse_id, $stock_id, $detail->quantity - $quantity);
                }
            }
            $detail->quantity = $increment ?  $quantity + $detail->quantity : $quantity;
            $detail->save();
        } else {
            $this->removeStockFromWarehouse($loadsheet->warehouse_id, $stock_id, $quantity);
            AllocationItem::create([
                'stock_id' => $stock_id,
                'quantity' => $quantity,
                'loadsheet_id' => $load_sheet_id
            ]);
        }


        return true;
    }

    public function removeStockFromWarehouse($warehouse_id, $stock_id, $quantity)
    {
        $stock = Stock::where('warehouse_id', $warehouse_id)->where('id', $stock_id)->first();
        if ($stock) {
            $stock->quantity = $stock->quantity - $quantity;
            $stock->save();
        }
        return true;
    }

    //add back stock to warehouse
    public function addStockToWarehouse($warehouse_id, $stock_id, $quantity)
    {
        $stock = Stock::where('warehouse_id', $warehouse_id)->where('id', $stock_id)->first();
        if ($stock) {
            $stock->quantity = $stock->quantity + $quantity;
            $stock->save();
        }
        return true;
    }


    public function addCustomerStops($loadsheet_id, $data)
    {
        $loadsheet = Loadsheet::find($loadsheet_id);
        foreach ($data as $key => $value) {
            //check if customer stop already exist
            $stop = CustomerStop::where('loadsheet_id', $loadsheet_id)->where('customer_id', $value)->first();
            if ($stop) {
                continue;
            } else {
                $loadsheet->customerStops()->create([
                    'customer_id' => $value,
                ]);
            }
        }
        $this->createLoadSheetHistory($loadsheet_id, 'Customer Stops Added', 'Customer Stops Added');
        return true;
    }


    public function removeCustomerStop($customer_stop_id)
    {
        $record = CustomerStop::find($customer_stop_id);
        $record->delete();
        $loadsheet = Loadsheet::find($record->loadsheet_id);
        $this->createLoadSheetHistory($record->loadsheet_id, 'Customer Stop Deleted', 'Customer Stop Deleted: ' . $record->customer->name);
        return true;
    }

    public function getLoadSheetsByStatus($status)
    {
        return Loadsheet::where('user_id', auth()->user()->id)->where('status', $status)->get();
    }

    //create loadsheet history
    public function createLoadSheetHistory($loadsheet_id, $status, $description)
    {
        $loadsheet = Loadsheet::find($loadsheet_id);
        $loadsheet->history()->create([
            'user_id' => auth()->user()->id,
            'status' => $status,
            'description' => $description,
        ]);
        return true;
    }

    //create function to set driver to be unavailable
    public function setDriverUnavailable($driver_id)
    {
        $driver = User::find($driver_id);
        $driver->is_available = false;
        $driver->save();
        return true;
    }
}
