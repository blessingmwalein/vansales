<?php

namespace App\Http\Controllers;

use App\Models\Currency;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Interfaces\CurrencyRepositoryInterface;
use App\Interfaces\PricingMethodRepositoryInterface;
use App\Interfaces\ProductPricingRepositoryInterface;

class CurrencyController extends Controller
{
    private CurrencyRepositoryInterface $currencyRepository;
    private PricingMethodRepositoryInterface $pricingMethodRepository;
    private ProductPricingRepositoryInterface $productPricingRepository;

    public function __construct(CurrencyRepositoryInterface $currencyRepository, PricingMethodRepositoryInterface $pricingMethodRepository, ProductPricingRepositoryInterface $productPricingRepository)
    {
        $this->currencyRepository = $currencyRepository;
        $this->pricingMethodRepository = $pricingMethodRepository;
        $this->productPricingRepository = $productPricingRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Settings/Index', [
            'currencies' => $this->currencyRepository->getPaginated(10),
            'pricingMethods' => $this->pricingMethodRepository->getPaginated(10),
            'productPricings' => $this->productPricingRepository->getPaginated(10),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|unique:currencies,name',
            'code' => 'required|string|unique:currencies,code',
            'symbol' => 'nullable|string|unique:currencies,symbol',
            'exchange_rate' => 'required|numeric',
            'is_default' => 'required|boolean',
        ]);

        $this->currencyRepository->create($data);
        return redirect()->back()->with('success', 'Currency created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(Currency $currency)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Currency $currency)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Currency $currency)
    {
        $data = $request->validate([
            'name' => 'required|string|unique:currencies,name,' . $currency->id,
            'code' => 'required|string|unique:currencies,code,' . $currency->id,
            'symbol' => 'nullable|string|unique:currencies,symbol,' . $currency->id,
            'exchange_rate' => 'required|numeric',
            'is_default' => 'required|boolean',
        ]);

        $this->currencyRepository->update($data, $currency->id);
        return redirect()->back()->with('success', 'Currency updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Currency $currency)
    {
        $this->currencyRepository->delete($currency->id);
        return redirect()->back()->with('success', 'Currency deleted successfully');
    }
}
