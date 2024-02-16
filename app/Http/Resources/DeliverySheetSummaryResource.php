<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DeliverySheetSummaryResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'product' => $this->stock->product,
            // 'invoice_' => $this->saleOrder->order_number,
            // 'currency' => $this->saleOrder->currency,
            'total_sold_qty' => $this->calculateTotalSoldQty($this->stock_id),
            'total_outload_qty' => $this->calculateTotalOutLoadQty($this->stock_id),
            'total_inload_qty' => $this->calculateTotalOutLoadQty($this->stock_id) -  $this->calculateTotalSoldQty($this->stock_id),
        ];
    }
}
