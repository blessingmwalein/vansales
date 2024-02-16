<?php

namespace App\Repositories;

use App\Interfaces\CompanyRepositoryInterface;
use App\Interfaces\CurrencyRepositoryInterface;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\UserRepositoryInterface;
use App\Interfaces\SubscriptionRepositoryInterface;
use App\Models\Company;
use App\Models\CompanySubscription;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class CompanyRepository implements CompanyRepositoryInterface
{
    private UserRepositoryInterface $userRepository;
    private SubscriptionRepositoryInterface $subscriptionRepository;
    private GeneralSettingRepositoryInterface $generalSettingsRepository;


    public function __construct(
        UserRepositoryInterface $userRepositoryInterface,
        SubscriptionRepositoryInterface $subscriptionRepositoryInterface,
        GeneralSettingRepositoryInterface $generalSettingsRepository
    ) {
        $this->userRepository = $userRepositoryInterface;
        $this->subscriptionRepository = $subscriptionRepositoryInterface;
        $this->generalSettingsRepository = $generalSettingsRepository;
    }
    public function getAllCompanies()
    {
        return Company::all();
    }

    public function getAllCompaniesPaginated($page = 10)
    {
        return Company::latest()->paginate($page);
    }

    public function createCompany(array $companyData, array $userData, $subscriptionData)
    {


        $company = Company::create([
            'name' => $companyData['name'],
            'email' => $companyData['companyEmail'],
            'phone' => $companyData['phone'],
            'address' => $companyData['companyAddress'],
            'bpn' => $companyData['bpn'],
            'city' => $companyData['city'],
            'description' => $companyData['description'],

        ]);

        $userData['company_id'] = $company->id;

        //remove role_id from user data
        $subscriptionData['company_id'] = $company->id;

        $subData = $this->subscriptionRepository->addCompanySubscription($subscriptionData);
        $roleData = array();
        $roleData['role_id'] = $userData['role_id'];
        unset($userData['role_id']);
        // $roleData['role_id'] = ;
        // unset($userData['role_id']);
        $user = $this->userRepository->createUser($userData, $roleData);

        $settings = $this->generalSettingsRepository->setDefaultSettingsForCompany($company->id);

        $company->has_default_settings = true;
        $company->save();
        return $company;
    }


    public function updateCompany(array $data, $id, array $subscriptionData)
    {
        $company = Company::find($id);

        // dd($company);
        $company->update($data);

        $subData = CompanySubscription::where('company_id', $company->id)
            ->first();

        if ($subData) {
            // dd($subData);
            $subData->period = $subscriptionData['period'];
            $subData->subscription_id = $subscriptionData['subscription_id'];
            $subData->save();
        }

        return $company;
    }

    // public function updateCompanySubscription($id, $subscriptionData)
    // {
    //     // $company = Company::find($id);

    //     $subscriptionData['company_id'] = $company->id;
    // }

    public function deleteCompany($id)
    {
        $company = Company::find($id);
        //detach all roles
        $company->roles()->detach();
        //delete company
        return $company->delete();
    }

    public function filter($name, $email, $bpn, $phone, $city, $from = null, $to = null)
    {
        $companies = Company::query();

        if ($name) {
            $companies->where('name', 'LIKE', "%{$name}%");
        }

        if ($email) {
            $companies->where('email', 'LIKE', "%{$email}%");
        }

        if ($bpn) {
            $companies->where('bpn', 'LIKE', "%{$bpn}%");
        }

        if ($phone) {
            $companies->where('phone', 'LIKE', "%{$phone}%");
        }

        if ($city) {
            $companies->where('phone', 'LIKE', "%{$city}%");
        }

        if ($from && $to) {
            $companies->whereBetween('created_at', [$from, $to]);
        }

        return $companies->paginate(10);
    }
}
