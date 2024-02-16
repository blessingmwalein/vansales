<?php

namespace App\Repositories;

use App\Interfaces\CurrencyRepositoryInterface;
use App\Models\Currency;
use App\Models\CurrencyPaymentMethod;

class CurrencyRepository implements CurrencyRepositoryInterface
{
    public function all()
    {
        return Currency::all();
    }

    public function create(array $data, $paymentMethods = [])
    {
        //check if default currency is being created

        $currency =  Currency::create($data);
        if (isset($data['is_default']) && $data['is_default'] == true) {
            $this->changeDefaultCurrency($currency->id);
        }
        if (isset($data['payment_methods'])) {
            $currency->paymentMethods()->attach($data['payment_methods']);
        }
        return $currency;
    }

    public function update(array $data, $id)
    {
        $record = Currency::find($id);
        //check if default currency is being updated
        if (isset($data['is_default']) && $data['is_default'] == true) {
            $this->changeDefaultCurrency($id);
        }
        if (isset($data['payment_methods'])) {
            //remove all payment methods
            $record->paymentMethods()->delete();
            //attach new payment methods
            $this->addPaymentMethods($data['payment_methods'], $record->id);
            unset($data['payment_methods']);
        }
        //remove payment methods from data
        return $record->update($data);
    }

    public function addPaymentMethods(array $data, $id)
    {
        foreach ($data as $paymentMethod) {
            CurrencyPaymentMethod::create([
                'currency_id' => $id,
                'payment_method_id' => $paymentMethod
            ]);
        }
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
