<?php

namespace App\Interfaces;

interface SaleOrderRepositoryInterface
{

    //sync sale order bulk
    public function syncSaleOrderBulk(array $data);

    //sync sale order individual
    public function syncSaleOrderIndividual(array $data);

    public function getPaginated($perPage = 10);

    public function getSaleOrderDetails($id, $page = 10);

    public function show($id);

    public function filter($customer, $status, $from, $to, $paymentMethod, $order_number, $currency, $loadsheet);
}
