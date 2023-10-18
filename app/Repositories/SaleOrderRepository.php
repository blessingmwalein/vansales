<?php

namespace App\Repositories;

use App\Interfaces\SaleOrderRepositoryInterface;
use App\Jobs\BulkSyncSalesOrders;
use App\Models\Currency;

class SaleOrderRepository implements SaleOrderRepositoryInterface
{
    //sync sale order bulk
    public function syncSaleOrderBulk(array $data)
    {
        // dispatch(new BulkSyncSalesOrders($data))->onQueue('bulk_sync');
        $job = new BulkSyncSalesOrders($data);
        $job->handle();
        return true;
    }

    //sync sale order individual
    public function syncSaleOrderIndividual(array $data)
    {
    }
}
