<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AllocationItemResource extends JsonResource
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
            'product' => $this->stock->product,
            'stock' => $this->stock,
            'defaultPrice' => $this->stock->product->getDefaultPrice(),
            'quantity' => $this->quantity,
            'unit' => $this->stock->product->unitMeasure,
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
