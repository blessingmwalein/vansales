<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Loadsheet extends Model
{
    use HasFactory;
    protected $guarded;

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($loadSheet) {
            $loadSheet->loadsheet_number = $loadSheet->generateLoadSheetNumber();
        });
    }


    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
        'start_date_time' => 'datetime:Y-m-d H:00',
    ];

    public function generateLoadSheetNumber()
    {
        //gen company name from env
        $prefix = env('LOADSHEET_PREFIX');
        $lastRecord = Loadsheet::latest()->first();
        if (!$lastRecord) {
            return $prefix . '0001';
        }
        $lastRecordId = $lastRecord->id;
        $code = $prefix . str_pad($lastRecordId + 1, 4, '0', STR_PAD_LEFT);
        return $code;
    }

    //create  function to set status
    public function setStatus($status)
    {
        $this->status = $status;
        $this->save();
    }

    public function history()
    {
        return $this->hasMany(LoadsheetHistory::class, 'loadsheet_id');
    }

    public function details()
    {
        return $this->hasMany(LoadSheetDetail::class, 'load_sheet_id');
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
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function customerStops()
    {
        return $this->hasMany(CustomerStop::class, 'loadsheet_id');
    }

    public function sales()
    {
        return $this->hasMany(SaleOrder::class, 'loadsheet_id');
    }
}
