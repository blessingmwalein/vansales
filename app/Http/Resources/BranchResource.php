<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BranchResource extends JsonResource
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
            'name' => $this->name,
            'address' => $this->address,
            'email' => $this->email,
            'phone_number' => $this->phone_number,
            'warehouse_name' => $this->warehouse->name,
            'warehouse_address' => $this->warehouse->location,
            'warehouse_code' => $this->warehouse->code,
            'warehouse_id' => $this->warehouse->id,
            'allocationItems' => StockResource::collection($this->warehouse->stocks),
        ];
    }
}
