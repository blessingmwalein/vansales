<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{

    use HasFactory;

    protected $guarded;

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($invoice) {
            $invoice->company_id = auth()->user()->company_id;
        });
    }


    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    public function items()
    {
        return $this->hasMany(InvoiceItem::class);
    }

    public function delivery()
    {
        return $this->belongsTo(Delivery::class, 'delivery_id');
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class, 'branch_id');
    }

    public function loadsheet()
    {
        return $this->belongsTo(Loadsheet::class, 'loadsheet_id');
    }

    public function deliverySheet()
    {
        return $this->belongsTo(DeliverySheet::class, 'delivery_sheet_id');
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }


}
