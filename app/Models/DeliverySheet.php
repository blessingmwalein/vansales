<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;


class DeliverySheet extends Model
{
    use HasFactory, CompanyScope;
    protected $guarded;

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($loadSheet) {
            $loadSheet->delivery_sheet_number = $loadSheet->generateDeliverySheetNumber();
            $loadSheet->company_id = auth()->user()->company_id;
        });
    }


    public function setStatus($status)
    {
        $this->status = $status;
        $this->save();
    }

    public function history()
    {
        return $this->hasMany(DeliveryHistory::class);
    }

    public function invoices()
    {
        return $this->hasMany(Invoice::class, 'delivery_sheet_id');
    }

    public function deliveries()
    {
        return $this->hasMany(Delivery::class, 'delivery_sheet_id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id');
    }

    public function truck()
    {
        return $this->belongsTo(Truck::class, 'truck_id');
    }

    //route relation
    public function route()
    {
        return $this->belongsTo(Route::class, 'route_id');
    }

    //user relation
    public function driver()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function getInvoiceItems()
    {
        $items = [];
        foreach ($this->invoices as $invoice) {
            foreach ($invoice->items as $item) {
                $items[] = $item;
            }
        }
        return collect($items)->unique('stock_id')->values()->all();
    }

    public function generateDeliverySheetNumber()
    {
        //gen company name from env
        $prefix = env('DELIVERYSHEET_PREFIX');
        $lastRecord = DeliverySheet::latest()->first();
        if (!$lastRecord) {
            return $prefix . '0001';
        }
        $lastRecordId = $lastRecord->id;
        $code = $prefix . str_pad($lastRecordId + 1, 4, '0', STR_PAD_LEFT);
        return $code;
    }
}
