<?php

namespace App\Repositories;

use App\Interfaces\CurrencyRepositoryInterface;
use App\Models\Currency;

class CurrencyRepository implements CurrencyRepositoryInterface
{
    public function all()
    {
        return Currency::all();
    }

    public function create(array $data)
    {
        return Currency::create($data);
    }

    public function update(array $data, $id)
    {
        $record = Currency::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return Currency::destroy($id);
    }

    public function show($id)
    {
        return Currency::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Currency::latest()->paginate($perPage);
    }

    //function to get default currency
    public function getDefaultCurrency()
    {
        return Currency::where('is_default', true)->first();
    }
}
