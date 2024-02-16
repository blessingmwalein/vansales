<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SaleOderDetailResource extends JsonResource
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
            'sales_order_id' => $this->sales_order_id,
            'stock_id' => $this->stock_id,
            'stock' => $this->stock,
            'product' => $this->stock->product,
            'quantity' => $this->quantity,
            'is_synced' => $this->is_synced == 1 ? true : false,
            'created_at' =>$this->created_at? $this->created_at->format('Y-m-d H:00') : null,
            'updated_at' =>$this->updated_at? $this->updated_at->format('Y-m-d H:00') : null,
        ];
    }
}
