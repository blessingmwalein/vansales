<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class CurrencyPaymentMethod extends Model
{
    use HasFactory;
    protected $guarded;

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            $model->company_id = auth()->user()->company_id;
        });
    }

    protected $with = ['paymentMethod'];


    public function currency()
    {
        return $this->belongsTo(Currency::class);
    }

    public function paymentMethod()
    {
        return $this->belongsTo(PaymentMethod::class);
    }
}
