<?php

namespace App\Http\Controllers;

use App\Http\Resources\InvoiceResource;
use App\Http\Resources\StockResource;
use App\Interfaces\BranchRepositoryInterface;
use App\Interfaces\UserRepositoryInterface;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Models\Branch;
use Illuminate\Http\Request;
use Inertia\Inertia;

class BranchController extends Controller
{

    private BranchRepositoryInterface $branchRepository;
    private WarehouseRepositoryInterface $warehouseRepository;
    private UserRepositoryInterface $userRepository;

    public function __construct(
        BranchRepositoryInterface $branchRepository,
        WarehouseRepositoryInterface $warehouseRepository,
        UserRepositoryInterface $userRepository
    ) {
        $this->branchRepository = $branchRepository;
        $this->warehouseRepository = $warehouseRepository;
        $this->userRepository = $userRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Branch/Index', [
            'branches' => $this->branchRepository->getPaginated(),
            'warehouses' => $this->warehouseRepository->all(),
            'users' => $this->userRepository->getAllUsers()
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
            'address' => 'required',
            'phone_number' => 'required',
            'email' => 'required',
            'warehouse_id' => 'required',
            'user_id' => 'required'
        ]);

        $this->branchRepository->create($data);
        return redirect()->back()->with('success', 'Branch Created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Branch $branch)
    {
        return Inertia::render(
            'Branch/Show',
            [
                'branch' => $branch,
                'stock' => StockResource::collection($this->branchRepository->getBranchStock($branch->id)),
                'invoices' => InvoiceResource::collection($branch->invoices()->paginate(10)),
            ]
        );
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Branch $branch)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Branch $branch)
    {
        $data = $request->validate([
            'name' => 'required',
            'address' => 'required',
            'phone_number' => 'required',
            'email' => 'required',
            'warehouse_id' => 'required',
            'user_id' => 'required'
        ]);

        $this->branchRepository->update($data, $branch->id);

        return redirect()->back()->with('success', 'Branch Updated.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Branch $branch)
    {
        $this->branchRepository->delete($branch->id);
        return redirect()->back()->with('success', 'Branch Deleted.');
    }
}
