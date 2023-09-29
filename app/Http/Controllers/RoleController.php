<?php

namespace App\Http\Controllers;

use App\Models\vc;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        return Inertia::render('User/Roles', [
            'roles' => Role::with('permissions')->paginate(5),
            'permissions_data' => Permission::all(),
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
            'name' => 'required|unique:roles,name',
        ]);
        $data['guard_name'] = 'web';

        $role = Role::create($data);

        return redirect()->back()->with('success', 'Role created successfully');
    }
    /**
     * Display the specified resource.
     */
    public function show(vc $vc)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(vc $vc)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Role $role)
    {
        $data = $request->validate([
            'name' => 'required|unique:roles,name,' . $role->id,
        ]);
        $role->update($data);

        return redirect()->back()->with('success', 'Role updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Role $role)
    {
        //detach all permissions
        $role->permissions()->detach();
        //delete role
        $role->delete();

        return redirect()->back()->with('success', 'Role deleted successfully');
    }
}
