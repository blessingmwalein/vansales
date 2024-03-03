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
use App\Interfaces\CurrencyRepositoryInterface;
use App\Interfaces\PricingMethodRepositoryInterface;
use App\Interfaces\PaymentMethodRepositoryInterface;
use App\Interfaces\ProductPricingRepositoryInterface;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\DeliveryRepositoryInterface;
use App\Interfaces\InvoiceRepositoryInterface;
use App\Interfaces\AllocationItemRepositoryInterface;
use App\Interfaces\UserRepositoryInterface;
use App\Interfaces\CompanyRepositoryInterface;
use App\Interfaces\BranchRepositoryInterface;
use App\Interfaces\SubscriptionRepositoryInterface;
use App\Models\Subscription;
use App\Repositories\ProductCategoryRepository;
use App\Repositories\TruckRepository;
use App\Repositories\UtilityRepository;
use App\Repositories\WarehouseRepository;
use App\Repositories\ProductRepository;
use App\Repositories\LoadSheetRepository;
use App\Repositories\CustomerRepository;
use App\Repositories\RouteRepository;
use App\Repositories\CurrencyRepository;
use App\Repositories\PricingMethodRepository;
use App\Repositories\PaymentMethodRepository;
use App\Repositories\ProductPricingRepository;
use App\Repositories\GeneralSettingRepository;
use App\Repositories\AllocationItemRepository;
use App\Repositories\UserRepository;
use App\Repositories\CompanyRepository;
use App\Repositories\DeliveryRepository;
use App\Repositories\SubscriptionRepository;
use App\Repositories\BranchRepository;
use App\Repositories\InvoiceRepository;
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
        $this->app->bind(CurrencyRepositoryInterface::class, CurrencyRepository::class);
        $this->app->bind(PricingMethodRepositoryInterface::class, PricingMethodRepository::class);
        $this->app->bind(PaymentMethodRepositoryInterface::class, PaymentMethodRepository::class);
        $this->app->bind(ProductPricingRepositoryInterface::class, ProductPricingRepository::class);
        $this->app->bind(GeneralSettingRepositoryInterface::class, GeneralSettingRepository::class);
        $this->app->bind(UserRepositoryInterface::class, UserRepository::class);
        $this->app->bind(CompanyRepositoryInterface::class, CompanyRepository::class);
        $this->app->bind(SubscriptionRepositoryInterface::class, SubscriptionRepository::class);
        $this->app->bind(AllocationItemRepositoryInterface::class, AllocationItemRepository::class);
        $this->app->bind(DeliveryRepositoryInterface::class, DeliveryRepository::class);
        $this->app->bind(BranchRepositoryInterface::class, BranchRepository::class);
        $this->app->bind(InvoiceRepositoryInterface::class, InvoiceRepository::class);
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}
