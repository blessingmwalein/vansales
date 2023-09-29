<?php

namespace App\Interfaces;

interface UtilityRepositoryInterface
{
    //unit measure functions
    public function getAllUnitMeasures();
    public function getAllUnitMeasuresPaginated($page);

    public function createUnitMeasure(array $data);

    public function updateUnitMeasure(array $data, $id);

    public function deleteUnitMeasure($id);


    //taxs functions
    public function getAllTaxs();
    public function getAllTaxsPaginated($page);

    public function createTax(array $data);

    public function updateTax(array $data, $id);

    public function deleteTax($id);
}
