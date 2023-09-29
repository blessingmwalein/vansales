<?php

namespace App\Repositories;

use App\Interfaces\UtilityRepositoryInterface;
use App\Models\ProductCategory;
use App\Models\Tax;
use App\Models\UnitMeasure;

class UtilityRepository implements UtilityRepositoryInterface
{
    //implement unit measure functions
    public function getAllUnitMeasures()
    {
        return UnitMeasure::all();
    }

    public function getAllUnitMeasuresPaginated($page)
    {
        return UnitMeasure::paginate($page);
    }

    public function createUnitMeasure(array $data)
    {
        return UnitMeasure::create($data);
    }

    public function updateUnitMeasure(array $data, $id)
    {
        $record = UnitMeasure::find($id);
        return $record->update($data);
    }

    public function deleteUnitMeasure($id)
    {
        return UnitMeasure::destroy($id);
    }


    //implement taxs functions
    public function getAllTaxs()
    {
        return Tax::all();
    }

    public function getAllTaxsPaginated($page)
    {
        return Tax::paginate($page);
    }

    public function createTax(array $data)
    {
        return Tax::create($data);
    }

    public function updateTax(array $data, $id)
    {
        $record = Tax::find($id);
        return $record->update($data);
    }

    public function deleteTax($id)
    {
        return Tax::destroy($id);
    }
}
