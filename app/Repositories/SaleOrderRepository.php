<?php

namespace App\Repositories;

use App\Interfaces\LoadSheetRepositoryInterface;
use App\Interfaces\SaleOrderRepositoryInterface;
use App\Jobs\BulkSyncSalesOrders;
use App\Models\Currency;

class SaleOrderRepository implements SaleOrderRepositoryInterface
{
    private LoadSheetRepositoryInterface $loadSheetRepository;

    public function __construct(LoadSheetRepositoryInterface $loadSheetRepository)
    {
        $this->loadSheetRepository = $loadSheetRepository;
    }

    //sync sale order bulk
    public function syncSaleOrderBulk(array $data)
    {
        // dispatch(new BulkSyncSalesOrders($data))->onQueue('bulk_sync');
        $job = new BulkSyncSalesOrders($data);
        $job->handle();
        $this->loadSheetRepository->createLoadSheetHistory($data[0]['loadsheet_id'], 'Synced', 'Loadsheet Sales Synced');
        return true;
    }

    //sync sale order individual
    public function syncSaleOrderIndividual(array $data)
    {
    }
}
