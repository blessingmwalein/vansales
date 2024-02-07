<?php

namespace App\Repositories;

use App\Interfaces\CustomerRepositoryInterface;
use App\Models\Customer;
use App\Models\SaleOrder;

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

    public function filter($name, $phone_number, $email, $routes, $from, $to)
    {
        $customers = Customer::query();

        if ($name) {
            $customers->where('name', 'LIKE', "%{$name}%");
        }

        if ($phone_number) {
            $customers->where('phone_number', 'LIKE', "%{$phone_number}%");
        }

        if ($email) {
            $customers->where('email', 'LIKE', "%{$email}%");
        }

        if ($routes) {
            $customers->whereIn('route_id', $routes);
        }

        if ($from && $to) {
            $customers->whereBetween('created_at', [$from, $to]);
        }

        return $customers->paginate(10);
    }

    public function getCashAccountCustomer()
    {
        //search for customer with name like cash account
        return Customer::where('name', 'like', '%' . 'cash account' . '%')->first();
    }

    public function syncCustomerFromApi(array $data)
    {

        foreach ($data as $customer) {
            if (!$this->checkIfCustomerExist($customer['email'], $customer['phone_number'])) {
                $newCustomer = Customer::create([
                    'name' => $customer['name'],
                    'email' => $customer['email'],
                    'phone_number' => $customer['phone_number'],
                    'address' => $customer['address'],
                    'route_id' => $customer['route_id'],
                    'lat' => $customer['lat'],
                    'lon' => $customer['lon'],
                ]);
                $this->addCustomerToInvoice($customer['order_number'], $newCustomer);
            }
        }
    }

    //add customer to invoice
    public function addCustomerToInvoice($orderNumber, $customer)
    {

        //find the invoice with the order id
        $invoice = SaleOrder::where('order_number', $orderNumber)->first();
        $invoice->customer_id = $customer->id;
        $invoice->save();
    }

    //check if customer already exist with emil or phone number
    public function checkIfCustomerExist($email, $phone_number)
    {
        return Customer::where('email', $email)->orWhere('phone_number', $phone_number)->first();
    }
}
