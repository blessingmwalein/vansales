<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductPricing extends Model
{
    use HasFactory;

    protected $guarded;

    protected $with = ['currency', 'pricingMethod'];

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            $model->company_id = auth()->user()->company_id;
        });
    }

    public function currency()
    {
        return $this->belongsTo(Currency::class, 'currency_id');
    }

    public function pricingMethod()
    {
        return $this->belongsTo(PricingMethod::class, 'pricing_method_id');
    }
}
