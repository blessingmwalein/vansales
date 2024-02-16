<?php

namespace App\Http\Controllers;

use App\Models\vc;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class PermissionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        return Inertia::render('User/Permissions', [
            'permissions_value' => Permission::latest()->paginate(5),
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
            'name' => 'required|unique:permissions,name',
        ]);
        $data['guard_name'] = 'web';

        $role = Permission::create($data);

        return redirect()->back()->with('success', 'Permission created successfully');
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
    public function update(Request $request, Permission $role)
    {
        $data = $request->validate([
            'name' => 'required|unique:permissions,name,' . $role->id,
        ]);
        $role->update($data);

        return redirect()->back()->with('success', 'Permission updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Permission $role)
    {
        //detach all permissions
        $role->permissions()->detach();
        //delete role
        $role->delete();

        return redirect()->back()->with('success', 'Permission deleted successfully');
    }

    public function assignRolePermission(Request $request)
    {
        $data = $request->validate([
            'role_id' => 'required',
            'permission_id' => 'required',
        ]);
        $role = Role::find($data['role_id']);
        $permission = Permission::find($data['permission_id']);
        $role->givePermissionTo($permission);
        return redirect()->back()->with('success', 'Permission assigned successfully');
    }


    public function removeRolePermission(Request $request)
    {
        $data = $request->validate([
            'role_id' => 'required',
            'permission_id' => 'required',
        ]);
        $role = Role::find($data['role_id']);
        $permission = Permission::find($data['permission_id']);

        $role->revokePermissionTo($permission);
        return redirect()->back()->with('success', 'Permission removed successfully');
    }
}
