<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use App\Traits\CompanyScope;


class LoadSheetDetail extends Model
{
    use HasFactory;
    protected $guarded;

    protected $with = ['stock'];

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];



    public function loadsheet()
    {
        return $this->belongsTo(Loadsheet::class, 'load_sheet_id');
    }

    public function stock()
    {
        return $this->belongsTo(Stock::class, 'stock_id');
    }
}
