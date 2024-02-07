<?php

namespace App\Repositories;

use App\Interfaces\WarehouseRepositoryInterface;
use App\Models\Stock;
use App\Models\Warehouse;

class WarehouseRepository implements WarehouseRepositoryInterface
{
    public function all()
    {
        return Warehouse::all();
    }

    public function create(array $data)
    {
        $mainWarehouse  = $this->checkMainWarehouse();
        if (isset($data['is_main_warehouse']) && $data['is_main_warehouse'] == true) {
            if ($mainWarehouse) {
                $mainWarehouse->is_main_warehouse = false;
                $mainWarehouse->save();
            }
        }
        return Warehouse::create($data);
    }

    public function update(array $data, $id)
    {
        $mainWarehouse  = $this->checkMainWarehouse();

        // dd($mainWarehouse);
        if (isset($data['is_main_warehouse']) && $data['is_main_warehouse'] == true) {
            if ($mainWarehouse) {
                $mainWarehouse->is_main_warehouse = false;
                $mainWarehouse->save();
            }
        }
        $record = Warehouse::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return Warehouse::destroy($id);
    }

    public function show($id)
    {
        return Warehouse::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Warehouse::latest()->paginate($perPage);
    }

    //create function to generate code


    public function getAllocatedStock($id, $page = 10)
    {
        $warehouse = Warehouse::find($id);
        return $warehouse->stocks()->paginate($page);
    }

    //aloocate bulk stock to warehouse
    public function allocateStock($data, $id)
    {

        foreach ($data as $key => $value) {
            $this->updateStock($id, $value['value'], $value['quantity']);
        }
        return true;
    }


    //check if product is already allocated to warehouse an update
    public function updateStock($warehouse_id, $product_id, $quantity)
    {
        $stock = Stock::where('warehouse_id', $warehouse_id)->where('product_id', $product_id)->first();
        if ($stock) {
            $stock->quantity = $stock->quantity + $quantity;
            $stock->save();
        } else {
            Stock::create([
                'product_id' => $product_id,
                'warehouse_id' => $warehouse_id,
                'quantity' => $quantity
            ]);
        }
        return true;
    }

    //search warestocks
    public function searchWareStock($id, $search)
    {
        $warehouse = Warehouse::find($id);

        //product name and code is in stocks products relationships
        return $warehouse->stocks()->whereHas('product', function ($query) use ($search) {
            $query->where('description', 'LIKE', '%' . $search . '%')->orWhere('code', 'LIKE', '%' . $search . '%');
        })->paginate(10);

        // return $warehouse->stocks()->where('product_id', 'LIKE', '%' . $search . '%')->paginate(10);
    }

    //check if there is already a main warehouse
    public function checkMainWarehouse()
    {
        return Warehouse::where('is_main_warehouse', true)->first();
    }
}
