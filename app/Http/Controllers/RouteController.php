<?php

namespace App\Http\Controllers;

use App\Interfaces\RouteRepositoryInterface;
use App\Models\Route;
use Illuminate\Http\Request;
use Inertia\Inertia;

class RouteController extends Controller
{
    private RouteRepositoryInterface $routeRepository;

    public function __construct(RouteRepositoryInterface $routeRepository)
    {
        $this->routeRepository = $routeRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Routes/Index', [
            'routes' => $this->routeRepository->getPaginated(10),
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
            'number_centers' => 'required',
            'start_lat' => 'required',
            'start_lon' => 'required',
            'nodes' => 'nullable|array',
        ]);

        $this->routeRepository->create($data);

        return redirect()->back()->with('success', 'Route created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Route $route)
    {
        //
        return Inertia::render('Routes/Show', [
            'route' => $route,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Route $route)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Route $route)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Route $route)
    {
        //
    }
}
