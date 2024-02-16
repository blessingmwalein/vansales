<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\CompanyScope;

class Product extends Model
{
    use HasFactory, CompanyScope;
    protected $guarded;

    protected $casts = [
        'created_at' => 'datetime:Y-m-d H:00',
    ];

    protected $with = ['unitMeasure', 'tax', 'prices'];
    //create before save event to set product code
    protected static function boot()
    {
        parent::boot();
        static::creating(function ($product) {
            $product->code = $product->generateCode();
            $product->company_id = auth()->user()->company_id;
        });
    }



    public function category()
    {
        return $this->belongsTo(ProductCategory::class, 'product_category_id');
    }

    public function unitMeasure()
    {
        return $this->belongsTo(UnitMeasure::class, 'unit_measure_id');
    }

    public function tax()
    {
        return $this->belongsTo(Tax::class, 'tax_id');
    }

    public function generateCode()
    {
        //gen company name from env
        $prefix = env('PRODUCT_PREFIX');
        $lastRecord = Product::latest()->first();
        if (!$lastRecord) {
            return $prefix . '0001';
        }
        $lastRecordId = $lastRecord->id;
        $code = $prefix . str_pad($lastRecordId + 1, 4, '0', STR_PAD_LEFT);
        return $code;
    }

    //STOCK RELATED
    public function stocks()
    {
        return $this->hasMany(Stock::class, 'product_id');
    }

    //get total stock quantity
    public function getTotalStockQuantity()
    {
        return $this->stocks()->sum('quantity');
    }

    public function prices()
    {
        return $this->hasMany(ProductPricing::class, 'product_id');
    }

    //get default price
    public function getDefaultPrice()
    {
        return $this->prices()->where('is_default', true)->first();
    }

}
