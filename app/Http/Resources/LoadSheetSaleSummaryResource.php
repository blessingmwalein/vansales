<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LoadSheetSaleSummaryResource extends JsonResource
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
            'order_number' => $this->saleOrder->order_number,
            'total_sale_qty' => $this->calculateTotalQty($this->stock_id),
            'total_outload_qty' => $this->calculateTotalOutloadQty($this->stock_id),
            'total_inload_qty' =>  $this->calculateTotalOutloadQty($this->stock_id) - $this->calculateTotalQty($this->stock_id),
        ];
    }
}
