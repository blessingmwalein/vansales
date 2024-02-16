<?php

namespace App\Interfaces;

interface DeliveryRepositoryInterface
{
    public function all();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    public function filter($driver, $truck, $route, $warehouse, $status, $from, $to);


    public function confirmDeliverySheet($id);
    public function completeDeliverySheet($id);
    public function startDeliverySheet($id);
    public function addDelivery($id, array $data);

    //get delivery sheet by status
    public function getDeliverySheetsByStatus($status);

    public function syncInvoices($id, array $invoices);

    public function getLoadSheetSummary($id);

    // public function getDeliveryInvoices(array $data);
    // public function updateDelivery($id, array $data);
    // public function deleteDelivery($id);
}
