<?php

namespace App\Repositories;

use App\Interfaces\RouteRepositoryInterface;
use App\Models\Route;

class RouteRepository implements RouteRepositoryInterface
{
    public function all()
    {
        return Route::all();
    }

    public function create(array $data)
    {
        $route = Route::create([
            'name' => $data['name'],
            'number_centers' => $data['number_centers'],
            'start_lat' => $data['start_lat'],
            'start_lon' => $data['start_lon'],
        ]);
        if (isset($data['nodes'])) {
            $this->saveRouteNodes($route,  $data['nodes']);
        }
    }

    public function update(array $data, $id)
    {
        $record = Route::find($id);
        return $record->update($data);
    }

    public function delete($id)
    {
        return Route::destroy($id);
    }

    public function show($id)
    {
        return Route::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return Route::latest()->paginate($perPage);
    }

    //search Route by license plate and make_model
    // public function searchRoute($search)
    // {
    //     return Route::where('license_plate', 'like', '%' . $search . '%')
    //         ->orWhere('make_model', 'like', '%' . $search . '%')
    //         ->paginate(10);
    // }

    //create function to save route nodes
    public function saveRouteNodes($route, $nodes)
    {
        foreach ($nodes as $node) {
            $route->nodes()->create([
                'name' => $node['name'],
                'lat' => $node['lat'],
                'lon' => $node['lon']
            ]);
        }
    }
}
