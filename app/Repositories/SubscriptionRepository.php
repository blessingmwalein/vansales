<?php

namespace App\Repositories;

use App\Interfaces\SubscriptionRepositoryInterface;
use App\Models\Company;
use App\Models\CompanySubscription;
use App\Models\Subscription;

class SubscriptionRepository implements SubscriptionRepositoryInterface
{
    public function all()
    {
        return Subscription::all();
    }

    public function create(array $data)
    {
        $data['features'] = json_encode($data['features']);

        return Subscription::create($data);
    }

    public function update(array $data, $id)
    {
        //
        $data['features'] = json_encode($data['features']);

        $record = Subscription::find($id);

        return $record->update($data);
    }

    public function delete($id)
    {
        return Subscription::destroy($id);
    }

    public function show($id)
    {
        return Subscription::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Subscription::latest()->paginate($perPage);
    }

    public function addFeaturesToSubscription($subscriptionId, $features)
    {
        $subscription = Subscription::find($subscriptionId);

        $subscription->features()->attach($features);

        return $subscription;
    }

    public function removeFeaturesFromSubscription($subscriptionId, $features)
    {
        $subscription = Subscription::find($subscriptionId);

        $subscription->features()->detach($features);

        return $subscription;
    }

    public function addCompanySubscription($company_data)
    {

        $companySub = CompanySubscription::create($company_data);

        return $companySub;
    }

    public function updateCompanySubscription($id, $subscriptionData)
    {
        $subscription = CompanySubscription::find($id);

        return $subscription->update($subscriptionData);
    }
}
