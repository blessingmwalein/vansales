<?php

use App\Http\Controllers\CustomerController;
use App\Http\Controllers\LoadsheetController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\ProductCategoryController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\RouteController;
use App\Http\Controllers\TaxController;
use App\Http\Controllers\TruckController;
use App\Http\Controllers\UnitMeasureController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\WarehouseController;
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
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');
});


//route prefix for admin
Route::prefix('admin')->middleware(['auth:sanctum', 'verified', 'isAdmin'])->group(function () {
    Route::resource('/users', UserController::class);
    Route::resource('/roles', RoleController::class);
    Route::resource('/permissions', PermissionController::class);
    Route::post('/assign-role-permission', [PermissionController::class, 'assignRolePermission'])->name('assignRolePermission');

    Route::resource('/warehouses', WarehouseController::class);
    Route::resource('/product-categories', ProductCategoryController::class);
    Route::resource('/unit-measures', UnitMeasureController::class)->except(['show', 'index']);
    Route::resource('/taxs', TaxController::class)->except(['show', 'index']);
    Route::get('/utilities', [UnitMeasureController::class, 'index'])->name('utilities.index');

    Route::resource('/products', ProductController::class)->except(['update']);
    Route::resource('/trucks', TruckController::class);
    Route::resource('/customers', CustomerController::class);
    Route::resource('/routes', RouteController::class);
    Route::resource('/loadsheets', LoadsheetController::class);
    Route::post('/update-product/{product}', [ProductController::class, 'update']);
    Route::post('/products-search', [ProductController::class, 'searchByCodeName'])->name('products.search');
    Route::post('/products-search-warehouse', [WarehouseController::class, 'searchWareStock'])->name('products.search.warehouse');
    Route::post('/loadsheets-search', [LoadsheetController::class, 'searchByLoadsheetNumber'])->name('loadsheet.search');
    Route::post('/filter-loaadsheets-status', [LoadsheetController::class, 'filterByStatus'])->name('loadsheet.filter');
    Route::post('/filter-loadsheets-date', [LoadsheetController::class, 'searchByDateRange'])->name('loadsheet.date');
    Route::post('/filter-loadsheets', [LoadsheetController::class, 'filter'])->name('loadsheet.filter');
    Route::post('/trucks-search', [TruckController::class, 'searchTruckByLicenceModel'])->name('trucks.search');
    Route::post('/customers-search', [CustomerController::class, 'searchCustomerByNameEmailPhoneNumber'])->name('customers.search');
    Route::post('/upload-excel-products', [ProductController::class, 'uploadExcelProducts'])->name('products.upload');
    Route::post('/save-excel-products', [ProductController::class, 'saveExcelProducts'])->name('products.save');
    Route::post('/allocate-stock', [WarehouseController::class, 'allocateStock'])->name('warehouse.allocate');
    Route::post('/load-stock', [LoadsheetController::class, 'loadStock'])->name('loadsheet.loadStock');
    Route::post('/update-stock', [LoadsheetController::class, 'updateStock'])->name('loadsheet.updateStock');
    Route::post('/confirm-loadsheet', [LoadsheetController::class, 'confirmLoadSheet'])->name('loadsheet.confirmLoadSheet');
    Route::post('/add-loadsheet-details', [LoadsheetController::class, 'addLoadSheetDetail'])->name('loadsheet.addLoadSheetDetail');
    Route::post('/update-loadsheet-details', [LoadsheetController::class, 'updateLoadSheetDetail'])->name('loadsheet.updateLoadSheetDetail');
    Route::post('/complete-loadsheet', [LoadsheetController::class, 'completeLoadSheet'])->name('loadsheet.completeLoadSheet');
    Route::post('/delete-loadsheet-detail', [LoadsheetController::class, 'deleteLoadSheetDetail'])->name('loadsheet.deleteLoadSheet');
    Route::post('/confirm-loadsheet', [LoadsheetController::class, 'confirmLoadSheetDetail'])->name('loadsheet.confirmLoadSheet');
    Route::post('/complete-loadsheet', [LoadsheetController::class, 'completeLoadSheetDetail'])->name('loadsheet.completeLoadSheet');
});

Route::get('/unauthorizes', function () {
    return Inertia::render('Unauthorizes');
})->name('unauthorized');
