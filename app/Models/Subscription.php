<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\Permission\Models\Permission;

class Subscription extends Model
{
    use HasFactory;

    protected $guarded;

    // public function features()
    // {
    //     return $this->hasMany(Permission::class, 'subscription_id', 'id');
    // }
}
