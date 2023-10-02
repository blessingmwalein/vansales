<?php

namespace App\Http\Controllers;

use App\Http\Resources\StockResource;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Models\Warehouse;
use Illuminate\Http\Request;
use Inertia\Inertia;

class WarehouseController extends Controller
{
    private WarehouseRepositoryInterface $warehouseRepository;

    public function __construct(WarehouseRepositoryInterface $warehouseRepository)
    {
        $this->warehouseRepository = $warehouseRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Warehouse/Index', [
            'warehouses' => $this->warehouseRepository->getPaginated(5),
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
            'name' => 'required|unique:warehouses,name',
            'location' => 'required',
        ]);

        $this->warehouseRepository->create($data);
        return redirect()->back()->with('success', 'Warehouse created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Warehouse $warehouse)
    {
        return Inertia::render('Warehouse/Show', [
            'warehouse' => $this->warehouseRepository->show($warehouse->id),
            'stocks' => StockResource::collection($this->warehouseRepository->getAllocatedStock($warehouse->id)),
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Warehouse $warehouse)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Warehouse $warehouse)
    {
        $data = $request->validate([
            'name' => 'required',
            'location' => 'required',
        ]);

        $this->warehouseRepository->update($data, $warehouse->id);
        return redirect()->back()->with('success', 'Warehouse updated.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Warehouse $warehouse)
    {
        $this->warehouseRepository->delete($warehouse->id);
        return redirect()->back()->with('success', 'Warehouse deleted.');
    }

    public function allocateStock(Request $request)
    {
        $this->warehouseRepository->allocateStock($request->products, $request->warehouse_id);
        return redirect()->back()->with('success', 'Stock allocated.');
    }

    public function searchWareStock(Request $request)
    {
        $search = $request->search;
        $stocks = $this->warehouseRepository->searchWareStock($request->id, $search);
        return StockResource::collection($stocks);
    }
}
