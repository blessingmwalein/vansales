<?php

namespace App\Repositories;

use App\Interfaces\CustomerRepositoryInterface;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\AllocationItemRepositoryInterface;
use App\Interfaces\PricingMethodRepositoryInterface;
use App\Models\CustomerStop;
use App\Models\Loadsheet;
use App\Models\LoadSheetDetail;
use App\Models\SaleOrder;
use App\Models\Stock;
use App\Models\Truck;
use App\Models\User;

class AllocationItemRepository implements AllocationItemRepositoryInterface
{


    public function removeStockFromWarehouse($warehouse_id, $stock_id, $quantity)
    {
        $stock = Stock::where('warehouse_id', $warehouse_id)->where('id', $stock_id)->first();
        if ($stock) {
            $stock->quantity = $stock->quantity - $quantity;
            $stock->save();
        }
        return true;
    }

    //add back stock to warehouse
    public function addStockToWarehouse($warehouse_id, $stock_id, $quantity)
    {
        $stock = Stock::where('warehouse_id', $warehouse_id)->where('id', $stock_id)->first();
        if ($stock) {
            $stock->quantity = $stock->quantity + $quantity;
            $stock->save();
        }
        return true;
    }
}
