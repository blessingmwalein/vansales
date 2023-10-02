<?php

namespace App\Interfaces;

interface LoadSheetRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    // public function updateStock($id, array $data);
    public function confirmLoadSheet($id);
    public function completeLoadSheet($id);

    public function searchByLoadsheetNumber($search);

    //filter loadsheet by status
    public function filterByStatus($status);

    //search by date range
    public function searchByDateRange($from, $to);

    public function filter($driver, $truck, $route, $warehouse, $status, $from, $to);

    //add stock to loadsheet
    public function addLoadSheetDetail($loadsheet_id, $data);
    public function updateLoadSheetDetail($detail_id, $data);
    public function deleteLoadSheetDetail($detail_id);
}
