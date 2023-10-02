<?php

namespace App\Repositories;

use App\Interfaces\CustomerRepositoryInterface;
use App\Models\Customer;

class CustomerRepository implements CustomerRepositoryInterface
{
    public function all()
    {
        return Customer::all();
    }

    public function create(array $data)
    {
        return Customer::create($data);
    }

    public function update(array $data, $id)
    {
        $record = Customer::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return Customer::destroy($id);
    }

    public function show($id)
    {
        return Customer::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Customer::latest()->paginate($perPage);
    }

    //search customer by name, email, phone number
    public function searchCustomerByNameEmailPhoneNumber($search)
    {
        return Customer::where('name', 'like', '%' . $search . '%')
            ->orWhere('email', 'like', '%' . $search . '%')
            ->orWhere('phone_number', 'like', '%' . $search . '%')
            ->get();
    }
}
