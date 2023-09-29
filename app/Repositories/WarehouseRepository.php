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
        $data['code'] = $this->generateCode();
        return Warehouse::create($data);
    }

    public function update(array $data, $id)
    {
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
        return Warehouse::paginate($perPage);
    }

    //create function to generate code
    public function generateCode()
    {
        //gen company name from env
        $companyName = env('COMPANY_NAME');
        $lastRecord = Warehouse::latest()->first();
        if (!$lastRecord) {
            return $companyName . '0001';
        }
        $lastRecordId = $lastRecord->id;
        $code = $companyName . str_pad($lastRecordId + 1, 4, '0', STR_PAD_LEFT);
        return $code;
    }

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
}
