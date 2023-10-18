<?php

namespace App\Http\Controllers;

use App\Interfaces\TruckRepositoryInterface;
use App\Models\Truck;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TruckController extends Controller
{
    private TruckRepositoryInterface $truckRepository;

    public function __construct(TruckRepositoryInterface $truckRepository)
    {
        $this->truckRepository = $truckRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Trucks/Index', [
            'trucks' => $this->truckRepository->getPaginated(),
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
            'make_model' => 'required',
            'license_plate' => 'required|unique:trucks,license_plate',
            'color' => 'required',
            'start_mileage' => 'required',
            'is_available' => 'required',
        ]);

        $this->truckRepository->create($data);

        return redirect()->back()->with('success', 'Truck created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Truck $truck)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Truck $truck)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Truck $truck)
    {
        $data = $request->validate(
            [
                'make_model' => 'required',
                'license_plate' => 'required',
                'color' => 'required',
                'start_mileage' => 'required',
                'is_available' => 'required',
            ]
        );
        $this->truckRepository->update($data, $truck->id);

        return redirect()->back()->with('success', 'Truck updated.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Truck $truck)
    {
        $this->truckRepository->delete($truck->id);

        return redirect()->back()->with('success', 'Truck deleted.');
    }

    public function searchTruckByLicenceModel(Request $request)
    {
        $search = $request->search;

        $trucks = $this->truckRepository->searchTruck($search);

        return $trucks;
    }
}
