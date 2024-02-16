<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;



class Route extends Model
{
    use HasFactory, CompanyScope;
    protected $guarded;

    protected $with = ['nodes'];

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

    public function nodes()
    {
        return $this->hasMany(RouteNodes::class);
    }

    public function customers()
    {
        return $this->hasMany(Customer::class);
    }
}
