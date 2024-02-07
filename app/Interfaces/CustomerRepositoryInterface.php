<?php

namespace App\Interfaces;

interface CustomerRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    //search customer by name, email, phone number
    public function searchCustomerByNameEmailPhoneNumber($search);

    //filter customer by name, email, phone number, routes and date range
    public function filter($name, $phone_number, $email, $routes, $from, $to);

    //get cash account customer
    public function getCashAccountCustomer();

    public function syncCustomerFromApi(array $data);

}
