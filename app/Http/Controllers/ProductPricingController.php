<?php

namespace App\Http\Controllers;

use App\Interfaces\ProductPricingRepositoryInterface;
use App\Models\ProductPricing;
use Illuminate\Http\Request;

class ProductPricingController extends Controller
{

    private ProductPricingRepositoryInterface $productPricingRepository;

    public function __construct(ProductPricingRepositoryInterface $productPricingRepository)
    {
        $this->productPricingRepository = $productPricingRepository;
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
            'currency_id' => 'required|integer',
            'pricing_method_id' => 'required|integer',
            'retail_price' => 'required|numeric',
            'wholesale_price' => 'required|numeric',
            'discount' => 'nullable|numeric',
            'is_default' => 'required|boolean',
        ]);

        
        $this->productPricingRepository->create($data);
        return redirect()->back()->with('success', 'Product pricing created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(ProductPricing $productPricing)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(ProductPricing $productPricing)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, ProductPricing $productPricing)
    {
        $data = $request->validate([
            'currency_id' => 'required|integer',
            'pricing_method_id' => 'required|integer',
            'retail_price' => 'required|numeric',
            'wholesale_price' => 'required|numeric',
            'discount' => 'nullable|numeric',
            'is_default' => 'required|boolean',
        ]);

        $this->productPricingRepository->update($data, $productPricing->id);
        return redirect()->back()->with('success', 'Product pricing updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ProductPricing $productPricing)
    {
        $this->productPricingRepository->delete($productPricing->id);

        return redirect()->back()->with('success', 'Product pricing deleted successfully');
    }
}
