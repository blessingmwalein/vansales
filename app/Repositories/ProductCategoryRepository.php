<?php

namespace App\Repositories;

use App\Interfaces\ProductCategoryRepositoryInterface;
use App\Models\ProductCategory;

class ProductCategoryRepository implements ProductCategoryRepositoryInterface
{
    public function all()
    {
        return ProductCategory::all();
    }

    public function create(array $data)
    {
        return ProductCategory::create($data);
    }

    public function update(array $data, $id)
    {
        $record = ProductCategory::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return ProductCategory::destroy($id);
    }

    public function show($id)
    {
        return ProductCategory::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return ProductCategory::latest()->paginate($perPage);
    }
}
