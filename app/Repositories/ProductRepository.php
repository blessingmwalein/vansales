<?php

namespace App\Repositories;

use App\Interfaces\ProductPricingRepositoryInterface;
use App\Interfaces\ProductRepositoryInterface;
use App\Models\Product;

class ProductRepository implements ProductRepositoryInterface
{
    private ProductPricingRepositoryInterface $productPricingRepository;

    public function __construct(ProductPricingRepositoryInterface $productPricingRepository)
    {
        $this->productPricingRepository = $productPricingRepository;
    }
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
        $product =  Product::create([
            'description' => $data['description'],
            'image' => $data['image'],
            'product_category_id' => $data['product_category_id'],
            'tax_id' => $data['tax_id'],
            'unit_measure_id' => $data['unit_measure_id'],
            'reorder_level' => $data['reorder_level'],
        ]);
        //create default product pricing
        if ($data['hasMoreThanOnePrices']) {
            foreach ($data['prices'] as $productPrice) {
                $productPrice['product_id'] = $product->id;
                $this->productPricingRepository->create($productPrice);
            }
        } else {
            $data['product_id'] = $product->id;
            $this->productPricingRepository->create([
                'product_id' => $product->id,
                'currency_id' => $data['currency_id'],
                'retail_price' => $data['retail_price'],
                'wholesale_price' => $data['wholesale_price'],
                'discount' => $data['discount'],
                'pricing_method_id' => $data['pricing_method_id'],
                'is_default' => true
            ]);
        }

        return $product;
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
        $record->update([
            'description' => $data['description'],
            'image' => $data['image'],
            'product_category_id' => $data['product_category_id'],
            'tax_id' => $data['tax_id'],
            'unit_measure_id' => $data['unit_measure_id'],
            'reorder_level' => $data['reorder_level'],
        ]);
        //update default product pricing
        if ($data['hasMoreThanOnePrices']) {
            foreach ($data['prices'] as $productPrice) {
                $productPrice['product_id'] = $record->id;
                $this->productPricingRepository->update($productPrice, $productPrice['id']);
            }
        } else {
            $data['product_id'] = $record->id;
            $this->productPricingRepository->update([
                'product_id' => $record->id,
                'currency_id' => $data['currency_id'],
                'retail_price' => $data['retail_price'],
                'wholesale_price' => $data['wholesale_price'],
                'discount' => $data['discount'],
                'pricing_method_id' => $data['pricing_method_id'],
                'is_default' => true
            ], $record->getDefaultPrice()->id);
        }

        return $record;
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

    //filter function
    public function filter($code, $description, $categories, $taxs, $unitMeasures, $from, $to)
    {
        $query = Product::query();
        if ($code) {
            $query->where('code', 'like', '%' . $code . '%');
        }
        if ($description) {
            $query->where('description', 'like', '%' . $description . '%');
        }
        if ($categories) {
            $query->whereIn('product_category_id', $categories);
        }
        if ($taxs) {
            $query->whereIn('tax_id', $taxs);
        }
        if ($unitMeasures) {
            $query->whereIn('unit_measure_id', $unitMeasures);
        }
        if ($from) {
            $query->where('created_at', '>=', $from);
        }
        if ($to) {
            $query->where('created_at', '<=', $to);
        }
        return $query->paginate(10);
    }
}
