<?php

namespace App\Interfaces;

interface CurrencyRepositoryInterface
{
    public function all();

    public function create(array $data, $paymentMethods = []);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    //function to get default currency
    public function getDefaultCurrency();
}
