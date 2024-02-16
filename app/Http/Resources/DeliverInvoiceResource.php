<?php

namespace App\Http\Resources;

use App\Models\DeliveryInvoiceItem;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DeliverInvoiceResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {

        // dd($this->items);
        return [
            'id' => $this->id,
            'delivery_id' => $this->delivery_id,
            'customer'=> $this->delivery->customer,
            'invoice_number' => $this->invoice_number,
            'status' => $this->status,
            'items' => DeliverInvoiceItemResource::collection($this->items),
            'totals' =>json_decode($this->totals),
            'tax' => json_decode($this->tax),
            'discount' => json_decode($this->discount),
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
