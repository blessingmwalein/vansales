<?php

namespace App\Interfaces;

interface WarehouseRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    //get allocated stock
    public function getAllocatedStock($id , $page = 10);

    //function to allocate bulk stock
    public function allocateStock($data, $id);

    //search warestocks
    public function searchWareStock($id, $search);
}
