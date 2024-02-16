<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LoadSheetSaleResource extends JsonResource
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
            'loadsheet_id' => $this->loadsheet_id,
            'customer'=> $this->customer,
            'order_number' => $this->order_number,
            'status' => $this->status,
            'items' => SaleOderDetailResource::collection($this->salesOrderDetails),
            'totals' =>json_decode($this->totals),
            'tax' => json_decode($this->tax),
            'discount' => json_decode($this->discount),
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
