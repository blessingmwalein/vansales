<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    use HasFactory;
    protected $guarded;

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    protected $with = ['paymentMethods'];

    public function paymentMethods()
    {
        return $this->hasMany(CurrencyPaymentMethod::class);
    }
}
