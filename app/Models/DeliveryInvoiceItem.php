<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryInvoiceItem extends Model
{
    use HasFactory;

    protected $guarded;

    // public function currency()
    // {
    //     return $this->belongsTo(Currency::class);
    // }

    public function stock()
    {
        return $this->belongsTo(Stock::class);
    }

    public function calculateTotalSoldQty($stockId)
    {
        $totalQty = DeliveryInvoiceItem::where('stock_id', $stockId)->sum('quantity');
        return $totalQty;
    }

    public function calculateTotalOutLoadQty($stockId)
    {
        $totalQty = DeliveryItem::where('stock_id', $stockId)->sum('quantity');
        return $totalQty;
    }


}
