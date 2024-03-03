<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;



class Branch extends Model
{
    use HasFactory, CompanyScope;

    protected $guarded;

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($branch) {
            $branch->company_id = auth()->user()->company_id;
        });
    }

    protected $with =['warehouse', 'user'];

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function invoices()
    {
        return $this->hasMany(Invoice::class);
    }
}
