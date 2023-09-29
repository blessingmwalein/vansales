<?php

namespace App\Imports;


use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Tax;
use App\Models\UnitMeasure;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithStartRow;


class ProductsImport implements ToModel,WithStartRow
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
            'product_category_id'    => $this->getCategoryId($row[1]),
            'tax_id' => $this->getTaxId($row[2]),
            'unit_measure_id' => $this->getUnitMeasureId($row[3]),
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

    //seaarch category with name string
    public function getCategoryId($name)
    {
        //use where like query to search
        $category = ProductCategory::where('name', 'like', '%' . $name . '%')->first();
        if ($category) {
            return $category->id;
        }
        //get first category
        $category = ProductCategory::first();
        return $category->id;
    }

    //search for tax with name string
    public function getTaxId($name)
    {
        //use where like query to search
        $tax = Tax::where('name', 'like', '%' . $name . '%')->first();
        if ($tax) {
            return $tax->id;
        }
        //get first tax
        $tax = Tax::first();
        return $tax->id;
    }

    //search for unit measure with name string
    public function getUnitMeasureId($name)
    {
        //use where like query to search
        $unitMeasure = UnitMeasure::where('name', 'like', '%' . $name . '%')->first();
        if ($unitMeasure) {
            return $unitMeasure->id;
        }
        //get first unit measure
        $unitMeasure = UnitMeasure::first();
        return $unitMeasure->id;
    }

    public function startRow(): int
    {
        return 2;
    }
}
