<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SaleOderResource extends JsonResource
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
            'order_number' => $this->order_number,
            'status' => $this->status,
            'payment_method' => $this->payment_method,
            'currency_id' => $this->currency_id,
            'customer_id' => $this->customer_id,
            'loadsheet_id' => $this->loadsheet_id,
            'customer' => $this->customer,
            'loadsheet' => $this->loadsheet,
            'currency' => $this->currency,
            'discount' => $this->discount,
            'tax' => $this->tax,
            'total' => $this->total,
            'total_items_synced' => $this->total_items_synced,
            'total_items_failed_synced' => $this->total_items_failed_synced,
            'is_synced' => $this->is_synced == 1 ? true : false,
            'details' => SaleOderDetailResource::collection($this->salesOrderDetails),
            'customer_signature' => $this->route,
            'driver_signature' => $this->customerStops,
            'receipt_url' => $this->receipt_url,
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
