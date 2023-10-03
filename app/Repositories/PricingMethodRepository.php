<?php

namespace App\Repositories;

use App\Interfaces\PricingMethodRepositoryInterface;
use App\Models\PricingMethod;

class PricingMethodRepository implements PricingMethodRepositoryInterface
{
    public function all()
    {
        return PricingMethod::all();
    }

    public function create(array $data)
    {
        return PricingMethod::create($data);
    }

    public function update(array $data, $id)
    {
        $record = PricingMethod::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return PricingMethod::destroy($id);
    }

    public function show($id)
    {
        return PricingMethod::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return PricingMethod::latest()->paginate($perPage);
    }

    //function to get default pricing method
    public function getDefaultPricingMethod()
    {
        return PricingMethod::where('is_default', true)->first();
    }
}
