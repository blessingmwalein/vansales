<?php

namespace App\Http\Controllers;

use App\Http\Resources\CompanyResource;
use App\Models\Company;
use Illuminate\Http\Request;
use App\Interfaces\CompanyRepositoryInterface;
use App\Interfaces\SubscriptionRepositoryInterface;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;

class CompanyController extends Controller
{

    private CompanyRepositoryInterface $companyRepository;
    private SubscriptionRepositoryInterface $subscriptionRepository;

    public function __construct(CompanyRepositoryInterface $companyRepository, SubscriptionRepositoryInterface $subscriptionRepository)
    {
        $this->companyRepository = $companyRepository;
        $this->subscriptionRepository = $subscriptionRepository;
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Company/Index', [
            'companies' => CompanyResource::collection($this->companyRepository->getAllCompaniesPaginated(10)),
            'roles' => Role::all(),
            'subscriptions' => $this->subscriptionRepository->all(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $companyData = $request->validate([
            'name' => 'required',
            'companyEmail' => 'required|email',
            'phone' => 'required',
            'companyAddress' => 'required',
            'bpn' => 'required | unique:companies',
            'city' => 'required',
            'description' => 'nullable',
        ]);

        $userData = $request->validate([
            'first_name' => 'required',
            'last_name' => 'required',
            'type' => 'required',
            'address' => 'nullable',
            'phone_number' => 'required:unique:users,phone_number',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|confirmed',
            'role_id' => 'required',
        ]);

        $subscriptionData = $request->validate([
            'subscription_id' => 'required',
            'period' => 'required',
        ]);

        $company = $this->companyRepository->createCompany($companyData, $userData, $subscriptionData);

        return redirect()->back()->with('success', 'Company created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(Company $company)
    {
        return Inertia::render('Company/Show', [
            'company' => new CompanyResource($company),
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Company $company)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Company $company)
    {
        $data = $request->validate([
            'name' => 'required',
            'email' => 'required|email',
            'phone' => 'required',
            'address' => 'required',
            'bpn' => 'required',
            'city' => 'required',
            'address' => 'nullable',
            'description' => 'nullable',
        ]);

        $subscriptionData = $request->validate([
            'subscription_id' => 'required',
            'period' => 'required',
        ]);

        $company = $this->companyRepository->updateCompany($data, $company->id, $subscriptionData);

        return redirect()->back()->with('success', 'Company updated successfully');
    }

    //update company subscription
    public function updateSubscription(Request $request)
    {
        $subData = $request->validate([
            'subscription_id' => 'required',
            'period' => 'required',
        ]);

        $cSub = $request->validate([
            'id' => 'required',
        ]);

        $company = $this->subscriptionRepository->updateCompanySubscription($cSub, $subData);

        return redirect()->back()->with('success', 'Company subscription updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Company $company)
    {
        //
    }

    public function filter(Request $request)
    {
        $name = $request->name;
        $email = $request->email;
        $phone = $request->phone;
        $city = $request->city;
        $bpn = $request->bpn;
        $from = $request->from;
        $to = $request->to;
        $companies = $this->companyRepository->filter($name, $email, $bpn, $phone, $city, $from, $to);
        return CompanyResource::collection($companies);
    }
}
