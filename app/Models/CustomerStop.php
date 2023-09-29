<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomerStop extends Model
{
    use HasFactory;
    protected $guarded;

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];
}
