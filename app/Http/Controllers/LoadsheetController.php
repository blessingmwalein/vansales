<?php

namespace App\Http\Controllers;

use App\Exports\LoadSheetDetailsExport;
use App\Exports\LoadSheetSummaryExport;
use App\Http\Resources\InvoiceResource;
use App\Http\Resources\InvoiceSummaryResource;
use App\Http\Resources\AllocationItemResource;
use App\Http\Resources\LoadSheetResource;
use App\Http\Resources\LoadSheetSaleResource;
use App\Http\Resources\LoadSheetSaleSummaryResource;
use App\Http\Resources\SaleOderResource;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\LoadSheetRepositoryInterface;
use App\Interfaces\RouteRepositoryInterface;
use App\Interfaces\TruckRepositoryInterface;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Models\AllocationItem;
use App\Models\Loadsheet;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Excel;

class LoadsheetController extends Controller
{
    private LoadSheetRepositoryInterface $loadSheetRepository;
    private TruckRepositoryInterface $truckRepository;
    private WarehouseRepositoryInterface $warehouseRepository;
    private RouteRepositoryInterface $routeRepository;
    private GeneralSettingRepositoryInterface $generalSettingRepository;

    public function __construct(
        LoadSheetRepositoryInterface $loadSheetRepository,
        TruckRepositoryInterface $truckRepository,
        WarehouseRepositoryInterface $warehouseRepository,
        RouteRepositoryInterface $routeRepository,
        GeneralSettingRepositoryInterface $generalSettingRepository
    ) {
        $this->loadSheetRepository = $loadSheetRepository;
        $this->truckRepository = $truckRepository;
        $this->warehouseRepository = $warehouseRepository;
        $this->routeRepository = $routeRepository;
        $this->generalSettingRepository = $generalSettingRepository;
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


        return Inertia::render('Loadsheet/Index', [
            'loadsheets' =>  LoadSheetResource::collection($this->loadSheetRepository->getPaginated(10)),
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
            'manual_allocate' => 'required',
        ]);
        $this->loadSheetRepository->create($request->all());
        return redirect()->back()->with('success', 'Loadsheet created successfully');
    }



    /**
     * Display the specified resource.
     */
    public function show(Loadsheet $loadsheet)
    {
        //get user with role salesman
        $users = User::whereHas('roles', function ($query) {
            $query->where('name', 'salesman');
        })->get();

        //filter user with open loadsheet return array of users
        $users = $users->filter(function ($user) {
            return $user->loadsheets()->where('status', '!=', 'Completed')->count() == 0;
        })->values()->toArray();

        $allDrivers = User::whereHas('roles', function ($query) {
            $query->where('name', 'salesman');
        })->get();

        //get details with latest created at

        return Inertia::render('Loadsheet/Show', [
            'loadsheet' => new LoadSheetResource($loadsheet),
            'allocationItems' => AllocationItemResource::collection($loadsheet->allocationItems()->latest()->get()),
            'trucks' => $this->truckRepository->getAvailableTrucks(),
            'warehouses' => $this->warehouseRepository->all(),
            'routes' => $this->routeRepository->all(),
            'users' => $users,
            'allDrivers' => $allDrivers,
            'allTrucks' => $this->truckRepository->all(),
            'summary' => InvoiceSummaryResource::collection($loadsheet->getInvoiceItems()),
            // 'summary' => $this->loadSheetRepository->getLoadSheetSummary($loadsheet->id),
            'invoices' => InvoiceResource::collection($loadsheet->invoices()->paginate(10)),
            'settings' => $this->generalSettingRepository->all(),
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Loadsheet $loadsheet)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Loadsheet $loadsheet)
    {
        $data = $request->validate([
            'truck_id' => 'required',
            'warehouse_id' => 'required',
            'route_id' => 'required',
            'user_id' => 'required',
            'start_date_time' => 'required',
        ]);

        $this->loadSheetRepository->update($data, $loadsheet->id);
        return redirect()->back()->with('success', 'Loadsheet updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Loadsheet $loadsheet)
    {
        $this->loadSheetRepository->delete($loadsheet->id);
        return redirect()->back()->with('success', 'Loadsheet deleted successfully');
    }

    //function to load stock
    public function addLoadSheetDetail(Request $request)
    {
        $data = $request->validate([
            'details' => 'required|array',
            'loadsheet_id' => 'required',
        ]);
        $this->loadSheetRepository->addLoadSheetDetail($data['loadsheet_id'], $data['details']);
        return redirect()->back()->with('success', 'Stock Details loaded successfully');
    }

    public function updateLoadSheetDetail(Request $request)
    {
        $data = $request->validate([
            'detail_id' => 'required',
            'load_sheet_id' => 'required',
            'quantity' => 'required',
        ]);
        $this->loadSheetRepository->updateLoadSheetDetail($data['detail_id'], $data);
        return redirect()->back()->with('success', 'Stock Details Updated successfully');
    }


    //confirm loadsheet
    public function confirmLoadSheet(Request $request)
    {
        $data = $request->validate([
            'id' => 'required',
        ]);
        $this->loadSheetRepository->confirmLoadSheet($data['id']);
        return redirect()->back()->with('success', 'Loadsheet confirmed successfully');
    }

    //complete loadsheet
    public function completeLoadSheet(Request $request)
    {
        $data = $request->validate([
            'id' => 'required',
        ]);
        $this->loadSheetRepository->completeLoadSheet($data['id']);
        return redirect()->back()->with('success', 'Loadsheet completed successfully');
    }


    public function searchByLoadsheetNumber(Request $request)
    {
        $data = $request->search;
        return LoadSheetResource::collection($this->loadSheetRepository->searchByLoadsheetNumber($data));
    }

    //filter loadsheet by status
    public function filterByStatus(Request $request)
    {
        $data = $request->status;
        return LoadSheetResource::collection($this->loadSheetRepository->filterByStatus($data));
    }

    //search by date range
    public function searchByDateRange(Request $request)
    {
        $from = $request->from;
        $to = $request->to;
        return LoadSheetResource::collection($this->loadSheetRepository->searchByDateRange($from, $to));
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
        return LoadSheetResource::collection($this->loadSheetRepository->filter($driver, $truck, $route, $warehouse, $status, $from, $to));
    }

    public function deleteLoadSheetDetail(Request $request)
    {
        $data = $request->validate([
            'detail_id' => 'required',
        ]);
        $this->loadSheetRepository->deleteLoadSheetDetail($data['detail_id']);
        return redirect()->back()->with('success', 'Stock Details deleted successfully');
    }

    public function confirmLoadSheetDetail(Request $request)
    {
        $data = $request->validate([
            'load_sheet_id' => 'required',
        ]);
        $this->loadSheetRepository->confirmLoadSheet($data['load_sheet_id']);
        return redirect()->back()->with('success', 'Loadsheet confirmed successfully');
    }
    public function completeLoadSheetDetail(Request $request)
    {
        $data = $request->validate([
            'load_sheet_id' => 'required',
        ]);
        $this->loadSheetRepository->completeLoadSheet($data['load_sheet_id']);
        return redirect()->back()->with('success', 'Loadsheet completed successfully');
    }
    public function completeLoadSheetDetailDriver(Request $request)
    {
        $data = $request->validate([
            'load_sheet_id' => 'required',
        ]);
        $this->loadSheetRepository->completeLoadSheet($data['load_sheet_id']);
        return $this->response('Loadsheet completed successfully', null, 200);
    }

    public function startLoadSheetDetail(Request $request)
    {
        $data = $request->validate([
            'load_sheet_id' => 'required',
        ]);
        $this->loadSheetRepository->startLoadSheet($data['load_sheet_id']);
        return $this->response('Loadsheet started successfully', null, 200);
    }

    //add customers stop to loadsheet
    public function addCustomerStops(Request $request)
    {
        $data = $request->validate([
            'customer_stops' => 'required|array',
            'loadsheet_id' => 'required',
        ]);
        $this->loadSheetRepository->addCustomerStops($data['loadsheet_id'], $data['customer_stops']);
        return redirect()->back()->with('success', 'Customer Stops loaded successfully');
    }

    //remove customer stop from loadsheet
    public function removeCustomerStop(Request $request)
    {
        $data = $request->validate([
            'customer_stop_id' => 'required',
        ]);
        $this->loadSheetRepository->removeCustomerStop($data['customer_stop_id']);
        return redirect()->back()->with('success', 'Customer Stop removed successfully');
    }

    //get current user loadsheets by status
    public function getLoadSheetsByStatus(Request $request)
    {
        $data = $request->status;
        return $this->response('User loadsheets', LoadSheetResource::collection($this->loadSheetRepository->getLoadSheetsByStatus($data)));
    }

    public function downloadLoadSheetSummary(Request $request)
    {
        $data = $request->validate([
            'loadsheet_id' => 'required',
        ]);
        $loadsheet = Loadsheet::find($data['loadsheet_id']);


        return Excel::download(new LoadSheetSummaryExport($data['loadsheet_id']), 'loadsheet_ ' . $loadsheet->loadsheet_number . 'summary.xlsx');
    }

    public function downloadLoadSheetDetails(Request $request)
    {
        $data = $request->validate([
            'loadsheet_id' => 'required',
        ]);
        $loadsheet = Loadsheet::find($data['loadsheet_id']);
        return Excel::download(new LoadSheetDetailsExport($data['loadsheet_id']), 'loadsheet' . $loadsheet->loadsheet_number . 'details.xlsx');
    }
}
