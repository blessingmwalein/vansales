<?php

namespace App\Http\Controllers;

use App\Http\Resources\DeliverInvoiceResource;
use App\Http\Resources\DeliveryResource;
use App\Http\Resources\DeliverySheetResource;
use App\Http\Resources\DeliverySheetSummaryResource;
use App\Http\Resources\InvoiceResource;
use App\Http\Resources\InvoiceSummaryResource;
use App\Models\DeliverySheet;
use Illuminate\Http\Request;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\DeliveryRepositoryInterface;
use App\Interfaces\RouteRepositoryInterface;
use App\Interfaces\TruckRepositoryInterface;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Models\User;
use Inertia\Inertia;

class DeliverySheetController extends Controller
{
    private TruckRepositoryInterface $truckRepository;
    private WarehouseRepositoryInterface $warehouseRepository;
    private RouteRepositoryInterface $routeRepository;
    private GeneralSettingRepositoryInterface $generalSettingRepository;
    private DeliveryRepositoryInterface $deliverySheetRepository;

    public function __construct(
        TruckRepositoryInterface $truckRepository,
        WarehouseRepositoryInterface $warehouseRepository,
        RouteRepositoryInterface $routeRepository,
        GeneralSettingRepositoryInterface $generalSettingRepository,
        DeliveryRepositoryInterface $deliverySheetRepository
    ) {
        $this->truckRepository = $truckRepository;
        $this->warehouseRepository = $warehouseRepository;
        $this->routeRepository = $routeRepository;
        $this->generalSettingRepository = $generalSettingRepository;
        $this->deliverySheetRepository = $deliverySheetRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //get user with role salesman and is is_available = true
        $users = User::whereHas('roles', function ($query) {
            $query->where('name', 'salesman');
        })->where('is_available', true)->get();


        $allDrivers = User::whereHas('roles', function ($query) {
            $query->where('name', 'salesman');
        })->get();


        return Inertia::render('Delivery/Index', [
            'deliverySheets' =>  DeliverySheetResource::collection($this->deliverySheetRepository->getPaginated(10)),
            'trucks' => $this->truckRepository->getAvailableTrucks(),
            'warehouses' => $this->warehouseRepository->all(),
            'routes' => $this->routeRepository->all(),
            'users' => $users,
            'allDrivers' => $allDrivers,
            'allTrucks' => $this->truckRepository->all(),
            'settings' => $this->generalSettingRepository->all(),
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
            'truck_id' => 'required',
            'warehouse_id' => 'required',
            'route_id' => 'required',
            'user_id' => 'required',
            'start_date_time' => 'required',
            'company_id' => 'nullable',
        ]);
        $this->deliverySheetRepository->create($data);
        return redirect()->back()->with('success', 'Delivery sheet created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(DeliverySheet $deliverySheet, Request $request)
    {

        // dd($deliverySheet);
        $users = User::whereHas('roles', function ($query) {
            $query->where('name', 'salesman');
        })->get();

        //filter user with open loadsheet return array of users
        $users = $users->filter(function ($user) {
            return $user->deliverySheets()->where('status', '!=', 'Completed')->count() == 0;
        })->values()->toArray();

        $allDrivers = User::whereHas('roles', function ($query) {
            $query->where('name', 'salesman');
        })->get();

        //get details with latest created at

        // dd(InvoiceResource::collection($deliverySheet->invoices));

        return Inertia::render('Delivery/Show', [
            'deliverySheet' => new DeliverySheetResource($deliverySheet),
            'trucks' => $this->truckRepository->getAvailableTrucks(),
            'invoices' => InvoiceResource::collection($deliverySheet->invoices),
            'warehouses' => $this->warehouseRepository->all(),
            'routes' => $this->routeRepository->all(),
            'users' => $users,
            'allDrivers' => $allDrivers,
            'allTrucks' => $this->truckRepository->all(),
            'settings' => $this->generalSettingRepository->all(),
            'deliveries' => DeliveryResource::collection($deliverySheet->deliveries),
            'summary' => InvoiceSummaryResource::collection($deliverySheet->getInvoiceItems()),
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(DeliverySheet $deliverySheet)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, DeliverySheet $deliverySheet)
    {
        $data = $request->validate([
            'truck_id' => 'required',
            'warehouse_id' => 'required',
            'route_id' => 'required',
            'user_id' => 'required',
            'start_date_time' => 'required',
        ]);

        $this->deliverySheetRepository->update($data, $deliverySheet->id);
        return redirect()->back()->with('success', 'Delivery sheet updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(DeliverySheet $deliverySheet)
    {
        //
    }

    public function filter(Request $request)
    {
        $driver = $request->driver;
        $truck = $request->truck;
        $route = $request->route;
        $warehouse = $request->warehouse;
        $status = $request->status;
        $from = $request->from;
        $to = $request->to;

        $results = $this->deliverySheetRepository->filter($driver, $truck, $route, $warehouse, $status, $from, $to);
        // dd($results);
        return DeliverySheetResource::collection($this->deliverySheetRepository->filter($driver, $truck, $route, $warehouse, $status, $from, $to));
    }


    public function addDelivery(Request $request)
    {
        $data = $request->validate([
            'delivery_sheet_id' => 'required',
            'customer_id' => 'required',
            'items' => 'required | array',
        ]);
        $this->deliverySheetRepository->addDelivery($data['delivery_sheet_id'], $data);
        return redirect()->back()->with('success', 'Delivery added successfully');
    }

    public function confirmDeliverySheet(Request $request)
    {
        $this->deliverySheetRepository->confirmDeliverySheet($request->id);
        return redirect()->back()->with('success', 'Delivery sheet confirmed successfully');
    }

    public function startDeliverySheet(Request $request)
    {
        $this->deliverySheetRepository->startDeliverySheet($request->id);
        return $this->response('Deliver Sheet Started Successfully', null, 200);
    }

    public function completeDeliverySheet(Request $request)
    {

        $this->deliverySheetRepository->completeDeliverySheet($request->id);
        return $this->response('Deliver Sheet Completed Successfully', null, 200);
    }

    public function getDeliverySheetByStatus(Request $request)
    {
        return DeliverySheetResource::collection($this->deliverySheetRepository->getDeliverySheetsByStatus($request->status));
    }


}
