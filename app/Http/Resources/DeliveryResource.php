<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DeliveryResource extends JsonResource
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
            'status' => $this->status,
            'customer' => $this->customer,
            'delivery_sheet' => $this->deliverySheet,
            'items' => DeliveryItemResource::collection($this->items),
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
