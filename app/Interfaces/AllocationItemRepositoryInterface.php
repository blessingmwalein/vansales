<?php

namespace App\Interfaces;

interface AllocationItemRepositoryInterface
{
    public function removeStockFromWarehouse($warehouse_id, $stock_id, $quantity);
    public function addStockToWarehouse($warehouse_id, $stock_id, $quantity);
}
