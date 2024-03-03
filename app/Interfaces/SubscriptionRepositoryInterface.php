<?php

namespace App\Interfaces;

interface SubscriptionRepositoryInterface
{
    public function all();
    public function getCompanySubscriptions();

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    public function addFeaturesToSubscription($subscriptionId, $features);

    public function removeFeaturesFromSubscription($subscriptionId, $features);

    public function addCompanySubscription($companyData);

    public function updateCompanySubscription($id, $subscriptionData);
}
