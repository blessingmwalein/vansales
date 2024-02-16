<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use App\Traits\CompanyScope;


class Delivery extends Model
{
    use HasFactory;
    protected $guarded;


    protected static function boot()
    {
        parent::boot();
        // static::creating(function ($delivery) {
        //     $delivery->loadsheet_number = $delivery->generateLoadSheetNumber();
        //     $delivery->company_id = auth()->user()->company_id;
        // });
    }

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
        'start_date_time' => 'datetime:Y-m-d H:00',
    ];

    public function history()
    {
        return $this->hasMany(LoadsheetHistory::class, 'loadsheet_id');
    }

    public function items()
    {
        return $this->hasMany(DeliveryItem::class, 'delivery_id');
    }

    public function deliverySheet()
    {
        return $this->belongsTo(DeliverySheet::class, 'delivery_sheet_id');
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }

    public function invoice()
    {
        return $this->belongsTo(DeliveryInvoice::class, 'delivery_id', 'id');
    }
}
