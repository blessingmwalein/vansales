<?php

namespace App\Http\Controllers;

use App\Interfaces\UtilityRepositoryInterface;
use App\Models\UnitMeasure;
use Illuminate\Http\Request;
use Inertia\Inertia;

class UnitMeasureController extends Controller
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
        return Inertia::render('Stock/Utilities', [
            'unitOfMeasurements' => $this->utilityRepository->getAllUnitMeasuresPaginated(5),
            'taxs' => $this->utilityRepository->getAllTaxsPaginated(5),
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
            'name' => 'required'
        ]);

        $this->utilityRepository->createUnitMeasure($data);
        return redirect()->back()->with('success', 'Unit measure created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(UnitMeasure $unitMeasure)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(UnitMeasure $unitMeasure)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, UnitMeasure $unitMeasure)
    {
        $data = $request->validate([
            'name' => 'required'
        ]);

        $this->utilityRepository->updateUnitMeasure($data, $unitMeasure->id);
        return redirect()->back()->with('success', 'Unit measure updated.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(UnitMeasure $unitMeasure)
    {
        $this->utilityRepository->deleteUnitMeasure($unitMeasure->id);
        return redirect()->back()->with('success', 'Unit measure deleted.');
    }
}
