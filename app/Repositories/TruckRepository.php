<?php

namespace App\Repositories;

use App\Interfaces\TruckRepositoryInterface;
use App\Models\Truck;

class TruckRepository implements TruckRepositoryInterface
{
    public function all()
    {
        return Truck::all();
    }

    public function create(array $data)
    {
        return Truck::create($data);
    }

    public function update(array $data, $id)
    {
        $record = Truck::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return Truck::destroy($id);
    }

    public function show($id)
    {
        return Truck::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Truck::latest()->paginate($perPage);
    }

    //search truck by license plate and make_model
    public function searchTruck($search)
    {
        return Truck::where('license_plate', 'like', '%' . $search . '%')
            ->orWhere('make_model', 'like', '%' . $search . '%')
            ->paginate(10);
    }

    //get available trucks
    public function getAvailableTrucks()
    {
        return Truck::where('is_available', '1')->get();
    }
}
