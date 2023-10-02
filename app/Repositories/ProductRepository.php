<?php

namespace App\Repositories;

use App\Interfaces\ProductRepositoryInterface;
use App\Models\Product;

class ProductRepository implements ProductRepositoryInterface
{
    public function all()
    {
        return Product::all();
    }

    public function create(array $data)
    {
        //check if datra has image
        if (isset($data['image'])) {
            $data['image'] = $this->uploadImage($data['image']);
        }
        // $data['code'] = $this->generateCode();
        return Product::create($data);
    }

    public function update(array $data, $id)
    {
        $record = Product::find($id);
        //check if datra has image

        //check if datra has image or if image is not empty string
        if ($data['image'] != "") {
            //delete old image
            if ($record->image) {
                unlink(public_path('storage/' . $record->image));
            }
            $data['image'] = $this->uploadImage($data['image']);
        } else {
            $data['image'] = $record->image;
        }

        // if (isset($data['image'])) {
        //     //delete old image
        //     if ($record->image) {
        //         unlink(public_path('storage/' . $record->image));
        //     }
        //     $data['image'] = $this->uploadImage($data['image']);
        // }
        return $record->update($data);
    }

    public function delete($id)
    {
        return Product::destroy($id);
    }

    public function show($id)
    {
        return Product::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Product::latest()->paginate($perPage);
    }

    public function generateCode()
    {
        //gen company name from env
        $prefix = env('PRODUCT_PREFIX');
        $lastRecord = Product::latest()->first();
        if (!$lastRecord) {
            return $prefix . '0001';
        }
        $lastRecordId = $lastRecord->id;
        $code = $prefix . str_pad($lastRecordId + 1, 4, '0', STR_PAD_LEFT);
        return $code;
    }

    //upload image
    public function uploadImage($image)
    {
        return  $image->store('products', ['disk' => 'public']);
    }

    //get product by category
    public function getByCategory($categoryId)
    {
        return Product::where('product_category_id', $categoryId)->paginate(10);
    }

    //search product by code or description
    public function searchByCodeName($search)
    {
        return Product::where('code', 'like', '%' . $search . '%')
            ->orWhere('description', 'like', '%' . $search . '%')
            ->paginate(10);
    }
}
