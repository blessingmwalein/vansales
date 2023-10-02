<?php

namespace App\Providers;

use App\Interfaces\ProductCategoryRepositoryInterface;
use App\Interfaces\UtilityRepositoryInterface;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Interfaces\TruckRepositoryInterface;
use App\Interfaces\ProductRepositoryInterface;
use App\Interfaces\CustomerRepositoryInterface;
use App\Interfaces\LoadSheetRepositoryInterface;
use App\Interfaces\RouteRepositoryInterface;
use App\Repositories\ProductCategoryRepository;
use App\Repositories\TruckRepository;
use App\Repositories\UtilityRepository;
use App\Repositories\WarehouseRepository;
use App\Repositories\ProductRepository;
use App\Repositories\LoadSheetRepository;
use App\Repositories\CustomerRepository;
use App\Repositories\RouteRepository;
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
        $this->app->bind(TruckRepositoryInterface::class, TruckRepository::class);
        $this->app->bind(CustomerRepositoryInterface::class, CustomerRepository::class);
        $this->app->bind(RouteRepositoryInterface::class, RouteRepository::class);
        $this->app->bind(LoadSheetRepositoryInterface::class, LoadSheetRepository::class);
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}