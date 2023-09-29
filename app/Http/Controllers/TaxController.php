<?php

namespace App\Http\Controllers;

use App\Interfaces\UtilityRepositoryInterface;

use App\Models\Tax;
use Illuminate\Http\Request;

class TaxController extends Controller
{
    private UtilityRepositoryInterface $utilityRepository;

    public function __construct(UtilityRepositoryInterface $utilityRepository)
    {
        $this->utilityRepository = $utilityRepository;
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
            'name' => 'required|unique:taxes,name',
            'rate' => 'required|numeric',
        ]);

        $this->utilityRepository->createTax($data);
        return redirect()->back()->with('success', 'Tax created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Tax $tax)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Tax $tax)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Tax $tax)
    {
        $data = $request->validate([
            'name' => 'required',
            'rate' => 'required|numeric',
        ]);

        $this->utilityRepository->updateTax($data, $tax->id);
        return redirect()->back()->with('success', 'Tax updated.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Tax $tax)
    {
        $this->utilityRepository->deleteTax($tax->id);
        return redirect()->back()->with('success', 'Tax deleted.');
    }
}
