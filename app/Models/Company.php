<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    use HasFactory;

    protected $guarded;

    public function employees()
    {
        return $this->hasMany(User::class);
    }

    public function subscription()
    {
        return $this->hasOne(CompanySubscription::class, 'company_id', 'id');
    }

    public function generalSettings()
    {
        return $this->hasMany(GeneralSetting::class, 'company_id', 'id');
    }


}
