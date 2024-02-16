<?php

namespace App\Http\Controllers;

use App\Interfaces\PricingMethodRepositoryInterface;
use App\Models\PricingMethod;
use Illuminate\Http\Request;

class PricingMethodController extends Controller
{
    private PricingMethodRepositoryInterface $pricingMethodRepository;

    public function __construct(PricingMethodRepositoryInterface $pricingMethodRepository)
    {
        $this->pricingMethodRepository = $pricingMethodRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
            'name' => 'required|string',
            'is_default' => 'nullable|boolean',
        ]);

        $this->pricingMethodRepository->create($data);
        return redirect()->back()->with('success', 'Pricing method created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(PricingMethod $pricingMethod)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(PricingMethod $pricingMethod)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, PricingMethod $pricingMethod)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'is_default' => 'nullable|boolean',
        ]);

        $this->pricingMethodRepository->update($data, $pricingMethod->id);
        return redirect()->back()->with('success', 'Pricing method updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(PricingMethod $pricingMethod)
    {
        $this->pricingMethodRepository->delete($pricingMethod->id);

        return redirect()->back()->with('success', 'Pricing method deleted successfully');
    }
}
