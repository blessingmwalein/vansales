<?php

namespace App\Imports;


use App\Models\Product;
use Maatwebsite\Excel\Concerns\ToModel;

class ProductsImport implements ToModel
{
    /**
     * @param array $row
     *
     * @return User|null
     */
    public function model(array $row)
    {
        return new Product([
            'description'     => $row[0],
            'product_category_id'    => intval($row[1]),
            'tax_id' => intval($row[2]),
            'unit_measure_id' => intval($row[3]),
            'retail_unit_price' => floatval($row[4]),
            'discount' => floatval($row[5]),
            'wholesale_unit_price' => floatval($row[6]),
            'reorder_level' => floatval($row[7]),
            'image' => $row[8],
        ]);
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
}
