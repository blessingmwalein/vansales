<?php

namespace App\Interfaces;

interface ProductPricingRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    //function to get default ProductPricing
    public function getDefaultProductPricing();
}
