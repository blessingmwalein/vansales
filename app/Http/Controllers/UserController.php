<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('User/Index', [
            'users' => User::with('roles')->paginate(10),
            'roles' => Role::all(),
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
        $userData = $request->validate([
            'first_name' => 'required',
            'last_name' => 'required',
            'phone_number' => 'required:unique:users,phone_number',
            'email' => 'required|unique:users,email',
            'password' => 'required|confirmed',
        ]);
        $roleData = $request->validate([
            'role_id' => 'required',
        ]);
        $userData['password'] = bcrypt($userData['password']);
        $user = User::create($userData);
        $role = Role::find($roleData['role_id']);
        $user->assignRole($role);

        return redirect()->back()->with('success', 'User created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $user)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {
        $data  = $request->validate([
            'first_name' => 'required',
            'last_name' => 'required',
            'phone_number' => 'required',
            'email' => 'required',
            'role_id' => 'required',
        ]);

        //check if password is set
        if ($request->password) {
            $data['password'] = bcrypt($request->password);
        }
        $user->update($data);

        return redirect()->back()->with('success', 'User updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        //detach all roles
        $user->roles()->detach();

        //delete user
        $user->delete();

        return redirect()->back()->with('success', 'User deleted successfully');
    }

    public  function profile()
    {
        return Inertia::render('Profile');
    }
}
