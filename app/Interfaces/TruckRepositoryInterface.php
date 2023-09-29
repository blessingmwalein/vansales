<?php

namespace App\Interfaces;

interface TruckRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    //search truck by license plate and make_model
    public function searchTruck($search);
}
