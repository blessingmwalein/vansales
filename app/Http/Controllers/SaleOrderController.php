<?php

namespace App\Http\Controllers;

use App\Http\Resources\SaleOderDetailResource;
use App\Http\Resources\SaleOderResource;
use App\Interfaces\CurrencyRepositoryInterface;
use App\Interfaces\PaymentMethodRepositoryInterface;
use App\Interfaces\SaleOrderRepositoryInterface;
use App\Models\SaleOrder;
use App\Models\SaleOrderDetail;
use Illuminate\Http\Request;
use Inertia\Inertia;

class SaleOrderController extends Controller
{

    private SaleOrderRepositoryInterface $saleOrderRepository;
    private PaymentMethodRepositoryInterface $paymentMethodRepository;
    private CurrencyRepositoryInterface $currencyRepository;

    public function __construct(
        SaleOrderRepositoryInterface $saleOrderRepository,
        PaymentMethodRepositoryInterface $paymentMethodRepository,
        CurrencyRepositoryInterface $currencyRepository
    ) {
        $this->saleOrderRepository = $saleOrderRepository;
        $this->paymentMethodRepository = $paymentMethodRepository;
        $this->currencyRepository = $currencyRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Sales/Index', [
            'sales' => SaleOderResource::collection($this->saleOrderRepository->getPaginated(10)),
            'paymentMethods' => $this->paymentMethodRepository->all(),
            'currencies' => $this->currencyRepository->all(),
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
        $this->saleOrderRepository->syncSaleOrderBulk($request->all());
        return $this->response('Sale Orders Synced', 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(SaleOrder $saleOrder)
    {
       
        return Inertia::render('Sales/Show', [
            'sale' => new SaleOderResource($this->saleOrderRepository->show($saleOrder->id)),
            'details' => SaleOderDetailResource::collection($this->saleOrderRepository->getSaleOrderDetails($saleOrder->id)),
        ]);
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

    public function filter(Request $request)
    {
        $customer = $request->customer;
        $status = $request->status;
        $paymentMethod = $request->paymentMethod;
        $order_number = $request->order_number;
        $currency = $request->currency;
        $loadsheet = $request->loadsheet;
        $from = $request->from;
        $to = $request->to;

        $sales = $this->saleOrderRepository->filter($customer, $status, $from, $to, $paymentMethod, $order_number, $currency, $loadsheet);
        return SaleOderResource::collection($sales);
    }
}
