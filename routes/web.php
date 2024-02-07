<?php

use App\Http\Controllers\CurrencyController;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\GeneralSettingController;
use App\Http\Controllers\LoadsheetController;
use App\Http\Controllers\PaymentMethodController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\PricingMethodController;
use App\Http\Controllers\ProductCategoryController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ProductPricingController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\RouteController;
use App\Http\Controllers\SaleOrderController;
use App\Http\Controllers\TaxController;
use App\Http\Controllers\TruckController;
use App\Http\Controllers\UnitMeasureController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\WarehouseController;
use App\Models\GeneralSetting;
use App\Models\ProductCategory;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
});


//route prefix for admin
Route::prefix('admin')->middleware(['auth:sanctum', 'verified', 'isAdmin'])->group(function () {
    Route::get('/profile', [UserController::class, 'profile'])->name('admin.profile');

    //users
    Route::resource('/users', UserController::class);
    Route::post('/search-users', [UserController::class, 'filter'])->name('users.search');

    Route::resource('/roles', RoleController::class);
    Route::resource('/permissions', PermissionController::class);
    Route::post('/assign-role-permission', [PermissionController::class, 'assignRolePermission'])->name('assignRolePermission');


    //product category routes
    Route::resource('/product-categories', ProductCategoryController::class);

    //unit measure routes
    Route::resource('/unit-measures', UnitMeasureController::class)->except(['show', 'index']);

    //tax routes
    Route::resource('/taxs', TaxController::class)->except(['show', 'index']);

    //utilities
    Route::get('/utilities', [UnitMeasureController::class, 'index'])->name('utilities.index');

    Route::resource('/products', ProductController::class)->except(['update']);
    Route::resource('/sales', SaleOrderController::class)->except(['update', 'show']);
    Route::get('/sales/{saleOrder}', [SaleOrderController::class, 'show']);
    //truck routes
    Route::resource('/trucks', TruckController::class);

    //customer routes
    Route::resource('/customers', CustomerController::class);
    Route::get('/customers-map', [CustomerController::class, 'map']);

    //route routes
    Route::resource('/routes', RouteController::class);

    //loadsheet routes
    Route::resource('/loadsheets', LoadsheetController::class);
    Route::post('/loadsheets-search', [LoadsheetController::class, 'searchByLoadsheetNumber'])->name('loadsheet.search');
    Route::post('/filter-loaadsheets-status', [LoadsheetController::class, 'filterByStatus'])->name('loadsheet.filter');
    Route::post('/filter-loadsheets-date', [LoadsheetController::class, 'searchByDateRange'])->name('loadsheet.date');
    Route::post('/filter-loadsheets', [LoadsheetController::class, 'filter'])->name('loadsheet.filter');
    Route::get('/filter-loadsheets', [LoadsheetController::class, 'index']);
    Route::get('/download-loadsheet-summary', [LoadsheetController::class, 'downloadLoadSheetSummary']);
    Route::get('/download-loadsheet-details', [LoadsheetController::class, 'downloadLoadSheetDetails']);

    Route::post('/filter-sales', [SaleOrderController::class, 'filter'])->name('sales.filter');
    Route::get('/filter-sales', [SaleOrderController::class, 'index']);

    Route::post('/confirm-loadsheet', [LoadsheetController::class, 'confirmLoadSheet'])->name('loadsheet.confirmLoadSheet');
    Route::post('/add-loadsheet-details', [LoadsheetController::class, 'addLoadSheetDetail'])->name('loadsheet.addLoadSheetDetail');
    Route::post('/update-loadsheet-details', [LoadsheetController::class, 'updateLoadSheetDetail'])->name('loadsheet.updateLoadSheetDetail');
    Route::post('/complete-loadsheet', [LoadsheetController::class, 'completeLoadSheet'])->name('loadsheet.completeLoadSheet');
    Route::post('/delete-loadsheet-detail', [LoadsheetController::class, 'deleteLoadSheetDetail'])->name('loadsheet.deleteLoadSheet');
    Route::post('/confirm-loadsheet', [LoadsheetController::class, 'confirmLoadSheetDetail'])->name('loadsheet.confirmLoadSheet');
    Route::post('/complete-loadsheet', [LoadsheetController::class, 'completeLoadSheetDetail'])->name('loadsheet.completeLoadSheet');
    Route::post('/add-customer-stops', [LoadsheetController::class, 'addCustomerStops'])->name('loadsheet.addCustomerStops');
    Route::post('/remove-customer-stop', [LoadsheetController::class, 'removeCustomerStop'])->name('loadsheet.removeCustomerStop');
    Route::post('/load-stock', [LoadsheetController::class, 'loadStock'])->name('loadsheet.loadStock');
    Route::post('/update-stock', [LoadsheetController::class, 'updateStock'])->name('loadsheet.updateStock');

    Route::post('/trucks-search', [TruckController::class, 'searchTruckByLicenceModel'])->name('trucks.search');
    Route::post('/customers-search', [CustomerController::class, 'filter'])->name('customers.search');

    //product
    Route::post('/upload-excel-products', [ProductController::class, 'uploadExcelProducts'])->name('products.upload');
    Route::post('/save-excel-products', [ProductController::class, 'saveExcelProducts'])->name('products.save');
    Route::post('/update-product/{product}', [ProductController::class, 'update']);
    Route::post('/products-search', [ProductController::class, 'searchByCodeName'])->name('products.search');
    Route::get('/products-search', [ProductController::class, 'index']);

    //warehouse
    Route::post('/allocate-stock', [WarehouseController::class, 'allocateStock'])->name('warehouse.allocate');
    Route::post('/products-search-warehouse', [WarehouseController::class, 'searchWareStock'])->name('products.search.warehouse');
    Route::resource('/warehouses', WarehouseController::class);

    //currency
    Route::resource('/currencies', CurrencyController::class)->except(['show', 'index']);

    //pricing method
    Route::resource('/pricing-methods', PricingMethodController::class);

    //payment method
    Route::resource('/payment-methods', PaymentMethodController::class);

    //product pricing
    Route::resource('/product-pricings', ProductPricingController::class);

    //product settings
    Route::get('/settings/product-settings', [CurrencyController::class, 'index'])->name('product.settings');

    //setting routes
    Route::resource('/settings/general-settings', GeneralSettingController::class);
    Route::post('/settings/update-general-settings', [GeneralSettingController::class, 'updateGeneralSettings']);
});

Route::get('/unauthorizes', function () {
    return Inertia::render('Unauthorizes');
})->name('unauthorized');
