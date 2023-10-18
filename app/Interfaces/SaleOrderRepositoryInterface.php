<?php

namespace App\Interfaces;

interface SaleOrderRepositoryInterface
{

    //sync sale order bulk
    public function syncSaleOrderBulk(array $data);

    //sync sale order individual
    public function syncSaleOrderIndividual(array $data);
}
