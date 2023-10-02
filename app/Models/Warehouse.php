<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Warehouse extends Model
{
    use HasFactory;

    protected $guarded;

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($warehouse) {
            $warehouse->code = $warehouse->generateCode();
        });
    }


    protected $casts = [
        'email_verified_at' => 'datetime',
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    public function stocks()
    {
        return $this->hasMany(Stock::class, 'warehouse_id');
    }

    public function generateCode()
    {
        //gen company name from env
        $companyName = env('COMPANY_NAME');
        $lastRecord = Warehouse::latest()->first();
        if (!$lastRecord) {
            return $companyName . '0001';
        }
        $lastRecordId = $lastRecord->id;
        $code = $companyName . str_pad($lastRecordId + 1, 4, '0', STR_PAD_LEFT);
        return $code;
    }
}
