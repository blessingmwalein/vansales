<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use App\Traits\CompanyScope;

class SaleOrder extends Model
{
    use HasFactory;
    protected $guarded;

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    // protected static function boot()
    // {
    //     parent::boot();
    //     static::creating(function ($model) {
    //         $model->company_id = auth()->user()->company_id;
    //     });
    // }

    public function salesOrderDetails()
    {
        return $this->hasMany(SaleOrderDetail::class);
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }

    public function currency()
    {
        return $this->belongsTo(Currency::class, 'currency_id');
    }

    public function loadsheet()
    {
        return $this->belongsTo(Loadsheet::class, 'loadsheet_id');
    }
}
