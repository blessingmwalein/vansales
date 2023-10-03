<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'code' => $this->code,
            'description' => $this->description,
            'category' => $this->category,
            'product_category_id' => $this->product_category_id,
            'tax_id' => $this->tax_id,
            'unit_measure_id' => $this->unit_measure_id,
            'unit_measure' => $this->unitMeasure,
            'tax' => $this->tax,
            'retail_unit_price' => $this->retail_unit_price,
            'discount' => $this->discount,
            'image' => $this->image,
            'wholesale_unit_price' => $this->wholesale_unit_price,
            'reorder_level' => $this->reorder_level,
            'available_quantity' => $this->getTotalStockQuantity(),
            // get created_at in format: 2021-01-01 00:00
            'created_at' => $this->created_at->format('Y-m-d H:i'),

            'pricies' => $this->prices,

            'default_price' => $this->getDefaultPrice(),
            // 'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
