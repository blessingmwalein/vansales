<?php

namespace App\Providers;

use App\Interfaces\ProductCategoryRepositoryInterface;
use App\Interfaces\UtilityRepositoryInterface;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Interfaces\ProductRepositoryInterface;
use App\Repositories\ProductCategoryRepository;
use App\Repositories\UtilityRepository;
use App\Repositories\WarehouseRepository;
use App\Repositories\ProductRepository;
use Illuminate\Support\ServiceProvider;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->bind(WarehouseRepositoryInterface::class, WarehouseRepository::class);
        $this->app->bind(ProductCategoryRepositoryInterface::class, ProductCategoryRepository::class);
        $this->app->bind(UtilityRepositoryInterface::class, UtilityRepository::class);
        $this->app->bind(ProductRepositoryInterface::class, ProductRepository::class);
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}
