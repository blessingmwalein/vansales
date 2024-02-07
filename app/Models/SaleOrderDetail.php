<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SaleOrderDetail extends Model
{
    use HasFactory;
    protected $guarded;

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    public function stock()
    {
        return $this->belongsTo(Stock::class, 'stock_id');
    }

    public function saleOrder()
    {
        return $this->belongsTo(SaleOrder::class, 'sale_order_id');
    }

    //create function calculate total qty for the sale order detail with the same stock id
    public function calculateTotalQty($stockId)
    {
        $totalQty = SaleOrderDetail::where('stock_id', $stockId)->sum('quantity');
        return $totalQty;
    }

    //create function calculate total price for the sale order detail with the same stock id

    public function calculateTotalPrice($stockId)
    {
        $totalQty = SaleOrderDetail::where('stock_id', $stockId)->sum('total_price');
        return $totalQty;
    }

    //create function to get total outload qty from loadsheet details with the same stock id
    public function calculateTotalOutloadQty($stockId)
    {
        $totalQty = LoadSheetDetail::where('stock_id', $stockId)->sum('quantity');
        return $totalQty;
    }

    

    //create function to get total inload qty from loadsheet details with the same stock id
    
}
