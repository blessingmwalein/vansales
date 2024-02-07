<?php

namespace App\Repositories;

use App\Interfaces\PaymentMethodRepositoryInterface;
use App\Models\PaymentMethod;

class PaymentMethodRepository implements PaymentMethodRepositoryInterface
{
    public function all()
    {
        return PaymentMethod::all();
    }

    public function create(array $data)
    {
        return PaymentMethod::create($data);
    }

    public function update(array $data, $id)
    {
        $record = PaymentMethod::find($id);

        //check if default pricing method is being updated
        if (isset($data['is_default'])) {
            $this->changeDefaultPaymentMethod($id);
        }
        return $record->update($data);
    }

    public function delete($id)
    {
        return PaymentMethod::destroy($id);
    }

    public function show($id)
    {
        return PaymentMethod::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return PaymentMethod::latest()->paginate($perPage);
    }

    //function to get default pricing method
    public function getDefaultPricingMethod()
    {
        return PaymentMethod::where('is_default', true)->first();
    }

    //change default pricing method
    public function changeDefaultPaymentMethod($id)
    {
        $pricingMethod = PaymentMethod::find($id);
        $pricingMethod->is_default = true;
        $pricingMethod->save();

        $pricingMethods = PaymentMethod::where('id', '!=', $id)->get();
        foreach ($pricingMethods as $pricingMethod) {
            $pricingMethod->is_default = false;
            $pricingMethod->save();
        }
    }
}
