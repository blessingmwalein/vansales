<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CompanyResource extends JsonResource
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
            'email' => $this->email,
            'phone' => $this->phone,
            'address' => $this->address,
            'bpn' => $this->bpn,
            'city' => $this->city,
            'description' => $this->description,
            'subscription_name' => $this->subscription->subscription->name,
            'subscription_id' => $this->subscription->subscription->id,
            // 'employees' => $this->employees,
            'subscription_period' => $this->subscription->period,
            'hasGeneralSettings' => $this->has_default_settings == 0 ? false : true,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
