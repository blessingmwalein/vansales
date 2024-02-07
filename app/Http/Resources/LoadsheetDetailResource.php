<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LoadsheetDetailResource extends JsonResource
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
            'load_sheet_id' => $this->load_sheet_id,
            'stock_id' => $this->stock_id,
            'stock' => $this->stock,
            'quantity' => $this->quantity,
            'default_price' => $this->stock->product->getDefaultPrice(),
            'created_at' => $this->created_at->format('Y-m-d H:00'),
            'updated_at' => $this->updated_at->format('Y-m-d H:00'),
        ];
    }
}
