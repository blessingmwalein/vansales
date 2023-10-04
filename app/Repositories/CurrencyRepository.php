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

        //check if default currency is being updated
        if (isset($data['is_default'])) {
            $this->changeDefaultCurrency($id);
        }
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

    //change default currency
    public function changeDefaultCurrency($id)
    {
        $currency = Currency::find($id);
        $currency->is_default = true;
        $currency->save();

        $currencies = Currency::where('id', '!=', $id)->get();
        foreach ($currencies as $currency) {
            $currency->is_default = false;
            $currency->save();
        }
    }
}
