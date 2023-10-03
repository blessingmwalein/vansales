<?php

namespace App\Repositories;

use App\Interfaces\ProductPricingRepositoryInterface;
use App\Models\ProductPricing;

class ProductPricingRepository implements ProductPricingRepositoryInterface
{
    public function all()
    {
        return ProductPricing::all();
    }

    public function create(array $data)
    {
        return ProductPricing::create($data);
    }

    public function update(array $data, $id)
    {
        $record = ProductPricing::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return ProductPricing::destroy($id);
    }

    public function show($id)
    {
        return ProductPricing::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return ProductPricing::latest()->paginate($perPage);
    }

    //function to get default ProductPricing
    public function getDefaultProductPricing()
    {
        return ProductPricing::where('is_default', true)->first();
    }
}
