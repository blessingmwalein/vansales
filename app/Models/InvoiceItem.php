<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InvoiceItem extends Model
{
    use HasFactory;

    protected $guarded;

    public function stock()
    {
        return $this->belongsTo(Stock::class, 'stock_id');
    }

    public function calculateTotalSoldQty()
    {
        $totalQty = InvoiceItem::where('stock_id', $this->stock_id)->where('invoice_id', $this->invoice_id)->sum('quantity');
        return $totalQty;
    }

    public function calculateTotalAllocatedQty()
    {

        $totalQty = AllocationItem::where('stock_id', $this->stock_id)->where('invoice_id', $this->invoice_id)->sum('quantity');
        return $totalQty;
    }
}
