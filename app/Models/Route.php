<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Route extends Model
{
    use HasFactory;
    protected $guarded;

    protected $with = ['nodes'];

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    public function nodes()
    {
        return $this->hasMany(RouteNodes::class);
    }
}
