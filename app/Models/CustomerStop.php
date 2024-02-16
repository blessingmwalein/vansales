<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use App\Traits\CompanyScope;


class CustomerStop extends Model
{
    use HasFactory;
    protected $guarded;


    protected static function boot()
    {
        parent::boot();
        // static::creating(function ($model) {
        //     $model->company_id = auth()->user()->company_id;
        // });
    }

    protected $with = ['customer'];

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];


    public function loadsheet()
    {
        return $this->belongsTo(Loadsheet::class, 'loadsheet_id');
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
}
