<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Fortify\TwoFactorAuthenticatable;
use Laravel\Jetstream\HasProfilePhoto;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use App\Traits\CompanyScope;



class User extends Authenticatable
{
    use HasApiTokens;
    use HasFactory;
    use HasProfilePhoto;
    use Notifiable;
    use TwoFactorAuthenticatable;
    use HasRoles;
    use CompanyScope;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $guarded;

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'two_factor_recovery_codes',
        'two_factor_secret',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array<int, string>
     */
    protected $appends = [
        'profile_photo_url',
    ];

    protected $with = ['warehouse', 'route', 'truck', 'company', 'subscription'];

    protected array $guard_name = ['sanctum', 'web'];

    public function loadsheets()
    {
        return $this->hasMany(Loadsheet::class, 'user_id');
    }
    public function deliverySheets()
    {
        return $this->hasMany(DeliverySheet::class, 'user_id');
    }

    //get is user has open loadsheets if status is not complete
    public function hasOpenLoadsheet()
    {
        $openLoadsheet = $this->loadsheets()->where('status', '!=', 'complete')->first();
        if ($openLoadsheet) {
            return true;
        }
        return false;
    }

    //get default currency
    public function getDefaultCurrency()
    {
        return Currency::where('is_default', true)->first();
    }

    //function to check if user has role admin
    public function isAdmin()
    {
        return $this->hasRole('admin');
    }

    //create attribute to get is_available as boolean
    public function getIsAvailableAttribute($value)
    {
        return $value == 1 ? true : false;
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class);
    }

    public function route()
    {
        return $this->belongsTo(Route::class);
    }

    public function truck()
    {
        return $this->belongsTo(Truck::class);
    }

    public function company()
    {
        return $this->belongsTo(Company::class);
    }

    //create function to get user company subscription
    public function subscription()
    {
        return $this->hasOne(CompanySubscription::class, 'company_id', 'company_id');
    }
}
