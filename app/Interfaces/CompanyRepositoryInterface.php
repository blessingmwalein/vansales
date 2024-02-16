<?php

namespace App\Interfaces;

interface CompanyRepositoryInterface
{

    public function getAllCompanies();

    public function getAllCompaniesPaginated($page);

    public function createCompany(array $companyData, array $userData, array $subscriptionData);

    public function updateCompany(array $data, $id, array $subscriptionData);

    public function deleteCompany($id);

    // public function updateCompanySubscription($id, $subscriptionData);

    public function filter($name, $email, $bpn, $phone, $city, $from = null, $to = null);
}
