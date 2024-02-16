<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;


class GeneralSetting extends Model
{
    use HasFactory, CompanyScope;

    protected $guarded;

    // protected static function boot()
    // {
    //     parent::boot();
    //     static::creating(function ($model) {
    //         $model->company_id = auth()->user()->company_id;
    //     });
    // }

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    //create get value attribute to convert value to boolean
    public function getValueAttribute($value)
    {
        return (bool) $value;
    }
}
