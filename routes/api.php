<?php

use App\Http\Controllers\LoadsheetController;
use App\Http\Controllers\SaleOrderController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


//auth routes
Route::post('driver/login', [UserController::class, 'login']);

Route::prefix('driver')->middleware(['auth:sanctum', 'verified'])->group(function () {
    Route::get('profile', [UserController::class, 'getAuthenticatedUser']);
    Route::post('profile', [UserController::class, 'updateProfile']);
    Route::post('change-password', [UserController::class, 'changePassword']);

    //loadsheet
    Route::get('loadsheets-status', [LoadsheetController::class, 'getLoadSheetsByStatus']);

    //sync sale order
    Route::post('sync-sale-order', [SaleOrderController::class, 'store']);
    Route::post('start-loadsheet', [LoadsheetController::class, 'startLoadSheetDetail'])->name('loadsheet.completeLoadSheet');
});
