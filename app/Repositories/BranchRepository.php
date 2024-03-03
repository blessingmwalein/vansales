<?php

namespace App\Repositories;

use App\Interfaces\BranchRepositoryInterface;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Models\Branch;
use App\Models\SaleOrder;

class BranchRepository implements BranchRepositoryInterface
{
    private WarehouseRepositoryInterface $warehouseRepositoryInterface;

    public function __construct(WarehouseRepositoryInterface $warehouseRepositoryInterface)
    {
        $this->warehouseRepositoryInterface = $warehouseRepositoryInterface;
    }

    public function all()
    {
        return Branch::all();
    }

    public function create(array $data)
    {
        return Branch::create($data);
    }

    public function update(array $data, $id)
    {
        $record = Branch::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return Branch::destroy($id);
    }

    public function show($id)
    {
        return Branch::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Branch::latest()->paginate($perPage);
    }


    public function filter($name, $phone_number, $email, $address)
    {
        $branches = Branch::query();

        if ($name) {
            $branches->where('name', 'LIKE', "%{$name}%");
        }

        if ($phone_number) {
            $branches->where('phone_number', 'LIKE', "%{$phone_number}%");
        }

        if ($email) {
            $branches->where('email', 'LIKE', "%{$email}%");
        }

        if ($address) {
            $branches->where('address', 'LIKE', "%{$address}%");
        }

        return $branches->paginate(10);
    }

    public function getBranchStock($branchId)
    {
        $branch = $this->show($branchId);
        return $this->warehouseRepositoryInterface->getAllocatedStock($branch->warehouse_id);
    }
}
