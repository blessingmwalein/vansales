<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;


class DeliverySheet extends Model
{
    use HasFactory, CompanyScope;
    protected $guarded;


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
        return $this->hasMany(DeliveryInvoice::class, 'delivery_sheet_id', 'id');
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
}
