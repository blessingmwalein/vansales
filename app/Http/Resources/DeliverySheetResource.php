<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Gate;


class DeliverySheetResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $canViewHistory = Gate::allows('viewHistory', $this->resource);

        return [
            'id' => $this->id,
            'status' => $this->status,
            'warehouse' => $this->warehouse,
            'truck' => $this->truck,
            'route' => $this->route,
            'driver' => $this->driver,
            'history' => $this->history,
            'start_date_time' => $this->start_date_time,
            'deliveries' => DeliveryResource::collection($this->deliveries),
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
