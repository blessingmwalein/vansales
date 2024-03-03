<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AllocationItem extends Model
{
    use HasFactory;

    protected $guarded;


    public function stock(){
        return $this->belongsTo(Stock::class);
    }

    public function loadsheet(){
        return $this->belongsTo(Loadsheet::class, 'id', 'loadsheet_id');
    }

    public function delivery(){
        return $this->belongsTo(Delivery::class);
    }


}
