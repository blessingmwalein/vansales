<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use App\Traits\CompanyScope;


class Stock extends Model
{
    use HasFactory;
    protected $guarded;

    protected $with = ['product'];

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

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id');
    }
}
