<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class InvoiceItemResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {

        // dd($this->stock_id);
        return [
            'id' => $this->id,
            'invoice_id' => $this->invoice_id,
            'stock_id' => $this->stock_id,
            'default_price' => $this->stock->product->getDefaultPrice(),
            'product' => $this->stock->product,
            'stock'=> $this->stock,// 'product' is a relationship in the 'Stock' model
            'quantity' => $this->quantity,
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
