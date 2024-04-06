<?php

namespace App\Http\Controllers;

use App\Models\PaymentMethod;
use Illuminate\Http\Request;
use App\Interfaces\PaymentMethodRepositoryInterface;

class PaymentMethodController extends Controller
{
    private PaymentMethodRepositoryInterface $paymentMethodRepository;

    public function __construct(PaymentMethodRepositoryInterface $paymentMethodRepository)
    {
        $this->paymentMethodRepository = $paymentMethodRepository;
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

        $this->paymentMethodRepository->create($data);
        return redirect()->back()->with('success', 'Pricing method created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(PaymentMethod $paymentMethod)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(PaymentMethod $paymentMethod)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, PaymentMethod $paymentMethod)
    {

        $data = $request->validate([
            'name' => 'required|string',
            'is_default' => 'nullable|boolean',

        ]);

        $this->paymentMethodRepository->update($data, $request->id);
        return redirect()->back()->with('success', 'Pricing method updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(PaymentMethod $paymentMethod)
    {
        $this->paymentMethodRepository->delete($paymentMethod->id);

        return redirect()->back()->with('success', 'Pricing method deleted successfully');
    }

    public function getPaymentMethods(Request $request)
    {

        return $this->response('Payment Methods', $this->paymentMethodRepository->all());
    }
}
