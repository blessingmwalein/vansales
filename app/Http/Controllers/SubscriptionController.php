<?php

namespace App\Http\Controllers;

use App\Http\Resources\SubscriptionResource;
use App\Models\Subscription;
use Illuminate\Http\Request;
use App\Interfaces\SubscriptionRepositoryInterface;
use Inertia\Inertia;
use Spatie\Permission\Models\Permission;

class SubscriptionController extends Controller
{

    private SubscriptionRepositoryInterface $subscriptionRepository;

    public function __construct(SubscriptionRepositoryInterface $subscriptionRepository)
    {

        $this->subscriptionRepository = $subscriptionRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Subscription/Index', [
            'subscriptions' => SubscriptionResource::collection($this->subscriptionRepository->all()),
            'features' => Permission::all(),
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
        $subscriptionData = $request->validate([
            'name' => 'required',
            'description' => 'nullable',
            'price' => 'required',
            'features' => 'nullable'
        ]);

        $this->subscriptionRepository->create($subscriptionData);

        return redirect()->back()->with('success', 'Subscription created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(Subscription $subscription)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Subscription $subscription)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Subscription $subscription)
    {
        $data = $request->validate([
            'name' => 'required',
            'description' => 'nullable',
            'price' => 'required',
            'features' => 'nullable'
        ]);

        $this->subscriptionRepository->update($data, $subscription->id);

        return redirect()->back()->with('success', 'Subscription updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Subscription $subscription)
    {
        $this->subscriptionRepository->delete($subscription->id);

        return redirect()->back()->with('success', 'Subscription deleted successfully');
    }
}
