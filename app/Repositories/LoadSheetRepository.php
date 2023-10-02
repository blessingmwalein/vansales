<?php

namespace App\Repositories;

use App\Interfaces\LoadSheetRepositoryInterface;
use App\Models\Loadsheet;
use App\Models\LoadSheetDetail;
use App\Models\Stock;
use App\Models\Truck;

class LoadSheetRepository implements LoadSheetRepositoryInterface
{
    public function all()
    {
        return Loadsheet::all();
    }

    public function create(array $data)
    {
        $record = Loadsheet::create($data);

        $record->setStatus('Created');
        $record->history()->create([
            'user_id' => auth()->user()->id,
            'status' => 'Created',
            'description' => 'Loadsheet Created',
        ]);
        //update truck is_available to false
        $record->truck->update(['is_available' => false]);

        return $record;
    }

    public function confirmLoadSheet($id)
    {
        $loadsheet = Loadsheet::find($id);
        $loadsheet->setStatus('Confirmed');
        $loadsheet->history()->create([
            'user_id' => auth()->user()->id,
            'status' => 'Confirmed',
            'description' => 'Loadsheet Confirmed',
        ]);
        return $loadsheet;
    }

    public function completeLoadSheet($id)
    {
        $loadsheet = Loadsheet::find($id);
        $loadsheet->setStatus('Completed');
        $loadsheet->history()->create([
            'user_id' => auth()->user()->id,
            'status' => 'Completed',
            'description' => 'Loadsheet Completed',
        ]);
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



        $record->history()->create([
            'user_id' => auth()->user()->id,
            'status' => 'Updated',
            'description' => 'Loadsheet Updated Changes:' . json_encode($record->getChanges()),
        ]);
        return $record;
    }

    public function delete($id)
    {
        $sheet = Loadsheet::find($id);
        //update truck is_available to true
        $sheet->truck->update(['is_available' => true]);
        $sheet->setStatus('Cancelled');
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
        $loadsheet->history()->create([
            'user_id' => auth()->user()->id,
            'status' => 'Loaded',
            'description' => 'Loadsheet Loaded',
        ]);
        return true;
    }

    public function updateLoadSheetDetail($detail_id, $data)
    {

        $record = LoadSheetDetail::find($detail_id);
        $update = $this->updateStock($record->stock_id, $record->load_sheet_id, $data['quantity'], false);
        return true;
    }
    public function deleteLoadSheetDetail($detail_id)
    {
        $record = LoadSheetDetail::find($detail_id);
        $this->addStockToWarehouse($record->loadsheet->warehouse_id, $record->stock_id, $record->quantity);
        $record->delete();

        $loadsheet = Loadsheet::find($record->load_sheet_id);
        $loadsheet->history()->create([
            'user_id' => auth()->user()->id,
            'status' => 'Deleted',
            'description' => 'Detail With Stock ID ' . $record->stock_id . ' Deleted',
        ]);

        return true;
    }


    public function updateStock($stock_id, $load_sheet_id, $quantity, $incerement = false)
    {
        $detail = LoadSheetDetail::where('load_sheet_id', $load_sheet_id)->where('stock_id', $stock_id)->first();

        $loadsheet = Loadsheet::find($load_sheet_id);
        // dd($stock_id, $load_sheet_id, $quantity, $isNew, $stock);
        if ($detail) {
            if ($incerement) {
                $this->removeStockFromWarehouse($loadsheet->warehouse_id, $stock_id, $quantity);
            } else {
                if ($quantity > $detail->quantity) {
                    $this->removeStockFromWarehouse($loadsheet->warehouse_id, $stock_id, $quantity - $detail->quantity);
                } else {
                    $this->addStockToWarehouse($loadsheet->warehouse_id, $stock_id, $detail->quantity - $quantity);
                }
            }
            $detail->quantity = $incerement ?  $quantity + $detail->quantity : $quantity;
            $detail->save();
        } else {
            $this->removeStockFromWarehouse($loadsheet->warehouse_id, $stock_id, $quantity);
            LoadSheetDetail::create([
                'stock_id' => $stock_id,
                'quantity' => $quantity,
                'load_sheet_id' => $load_sheet_id
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
}
