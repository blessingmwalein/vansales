<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;


class Customer extends Model
{
    use HasFactory, CompanyScope;
    protected $guarded;


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

    protected $with = ['route'];

    public function route()
    {
        return $this->belongsTo(Route::class);
    }
}
