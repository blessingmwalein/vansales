<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;


class Currency extends Model
{
    use HasFactory, CompanyScope;
    protected $guarded;

    //save company_id upon saving
    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            $model->company_id = auth()->user()->company_id;
        });
    }

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    protected $with = ['paymentMethods'];

    public function paymentMethods()
    {
        return $this->hasMany(CurrencyPaymentMethod::class);
    }
}
