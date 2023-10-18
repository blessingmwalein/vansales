<?php

namespace App\Http\Controllers;

use App\Interfaces\SaleOrderRepositoryInterface;
use App\Models\SaleOrder;
use Illuminate\Http\Request;

class SaleOrderController extends Controller
{

    private SaleOrderRepositoryInterface $saleOrderRepository;

    public function __construct(SaleOrderRepositoryInterface $saleOrderRepository)
    {
        $this->saleOrderRepository = $saleOrderRepository;
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
        $this->saleOrderRepository->syncSaleOrderBulk($request->all());
        return $this->response('Sale Orders Synced', 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(SaleOrder $saleOrder)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(SaleOrder $saleOrder)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, SaleOrder $saleOrder)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(SaleOrder $saleOrder)
    {
        //
    }
}
