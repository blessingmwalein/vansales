<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Gate;

class LoadSheetResource extends JsonResource
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
            'loadsheet_number' => $this->loadsheet_number,
            'status' => $this->status,
            'truck' => $this->truck,
            'user' => $this->user,
            'warehouse' => $this->warehouse,
            'history' => $canViewHistory ? $this->history : null,
            'details' => LoadsheetDetailResource::collection($this->details),
            'route' => $this->route,
            'customer_stops' => $this->customerStops,
            'start_date_time' => $this->start_date_time->format('Y-m-d H:00'),
            'created_at' => $this->created_at->format('Y-m-d H:00'),
        ];
    }
}
