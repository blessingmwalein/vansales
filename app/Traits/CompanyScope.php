<?php
namespace App\Traits;

use Illuminate\Database\Eloquent\Builder;

trait CompanyScope
{
    protected static function bootCompanyScope()
    {
        //set this trait to logged in Users with type of external
        if (auth()->check() && auth()->user()->type == 'External') {
            static::addGlobalScope('company', function (Builder $builder) {
                $builder->where('company_id', auth()->user()->company_id);
            });
        }
    }
}
