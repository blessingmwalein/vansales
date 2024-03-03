<?php

namespace App\Interfaces;

interface BranchRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    //filter customer by name, email, phone number, routes and date range
    public function filter($name, $phone_number, $email,$address);

    public function getBranchStock($branchId);

}
