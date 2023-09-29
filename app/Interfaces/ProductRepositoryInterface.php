<?php

namespace App\Interfaces;

interface ProductRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    public function getByCategory($category_id);

    public function searchByCodeName($search);
}
