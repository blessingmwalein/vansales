<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryItem extends Model
{
    use HasFactory;

    protected $guarded;

    // protected $with = ['stock'];

    public function stock()
    {
        return $this->belongsTo(Stock::class, 'stock_id');
    }
}
