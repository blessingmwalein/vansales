<?php

namespace App\Http\Controllers;

use App\Interfaces\CustomerRepositoryInterface;
use App\Interfaces\RouteRepositoryInterface;
use App\Interfaces\TruckRepositoryInterface;
use App\Models\Customer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class CustomerController extends Controller
{
    private CustomerRepositoryInterface $customerRepository;
    private RouteRepositoryInterface $routeRepository;

    public function __construct(CustomerRepositoryInterface $customerRepository, RouteRepositoryInterface $routeRepository)
    {
        $this->customerRepository = $customerRepository;
        $this->routeRepository = $routeRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Customers/Index', [
            'customers' => $this->customerRepository->getPaginated(),
            'routes' => $this->routeRepository->all()
        ]);
    }
    public function map()
    {
        return Inertia::render('Customers/Map', [
            'customers' => $this->customerRepository->all(),
            'routes' => $this->routeRepository->all()
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

        $data = $request->validate([
            'name' => 'required',
            'email' => 'required',
            'address' => 'required',
            'phone_number' => 'required',
            'lat' => 'nullable',
            'lon' => 'nullable',
            'route_id' => 'nullable'
        ]);

        $this->customerRepository->create($data);

        return redirect()->back()->with('success', 'Customer created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Customer $customer)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Customer $customer)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Customer $customer)
    {
        $data = $request->validate([
            'name' => 'required',
            'email' => 'required',
            'address' => 'required',
            'phone_number' => 'required',
            'lat' => 'nullable',
            'lon' => 'nullable',
            'route_id' => 'nullable'
        ]);

        $this->customerRepository->update($data, $customer->id);

        return redirect()->back()->with('success', 'Customer updated.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Customer $customer)
    {
        $this->customerRepository->delete($customer->id);

        return redirect()->back()->with('success', 'Customer deleted.');
    }

    public function filter(Request $request)
    {
        $name = $request->name;
        $email = $request->email;
        $phone_number = $request->phone_number;
        $routes = $request->routes;
        $from = $request->from;
        $to = $request->to;
        $customers = $this->customerRepository->filter($name, $phone_number, $email, $routes, $from, $to);
        return $customers;
    }

    public function syncCustomersFromMobile(Request $request)
    {
        // $data = $request->validate([
        //     'customers' => 'required|array',
        //     'loadsheet_id' => 'required'
        // ]);

        $this->customerRepository->syncCustomerFromApi($request->all());

        return $this->response('Customers Synced', 200);
    }
}
