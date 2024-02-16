<?php

namespace App\Http\Controllers;

use App\Interfaces\CompanyRepositoryInterface;
use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Interfaces\RouteRepositoryInterface;
use App\Interfaces\TruckRepositoryInterface;
use App\Interfaces\UserRepositoryInterface;
use App\Interfaces\WarehouseRepositoryInterface;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    private UserRepositoryInterface $userRepository;
    private GeneralSettingRepositoryInterface $generalSettingRepository;
    private WarehouseRepositoryInterface $warehouseRepository;
    private TruckRepositoryInterface $truckRepository;
    private RouteRepositoryInterface $routeRepository;
    private CompanyRepositoryInterface $companyRepository;

    public function __construct(
        UserRepositoryInterface $userRepository,
        GeneralSettingRepositoryInterface $generalSettingRepository,
        WarehouseRepositoryInterface $warehouseRepository,
        TruckRepositoryInterface $truckRepository,
        RouteRepositoryInterface $routeRepository,
        CompanyRepositoryInterface $companyRepository
    ) {
        $this->userRepository = $userRepository;
        $this->generalSettingRepository = $generalSettingRepository;
        $this->warehouseRepository = $warehouseRepository;
        $this->truckRepository = $truckRepository;
        $this->routeRepository = $routeRepository;
        $this->companyRepository = $companyRepository;
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $loggedInUser = auth()->user();
        return Inertia::render('User/Index', [
            'users' => $this->userRepository->getAllUsersPaginated(10),
            'roles' => $loggedInUser->type == 'External' ? Role::where('name', '!=', 'admin')->get() : Role::all(),
            'settings' => $this->generalSettingRepository->all(),
            'warehouses' => $this->warehouseRepository->all(),
            'trucks' => $this->truckRepository->all(),
            'routes' => $this->routeRepository->all(),
            'companies' => $this->companyRepository->getAllCompanies(),
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
            'type' => 'required',
            'warehouse_id' => $this->generalSettingRepository->checkIfSettingIsActivated('Warehouse') ? 'required' : 'nullable',
            'route_id' => $this->generalSettingRepository->checkIfSettingIsActivated('Routes') ? 'required' : 'nullable',
            'truck_id' => $this->generalSettingRepository->checkIfSettingIsActivated('Trucks') ? 'required' : 'nullable',
            'address' => 'required',
            'company_id' => 'nullable',
        ]);

        $roleData = $request->validate([
            'role_id' => 'required',
        ]);

        $this->userRepository->createUser($userData, $roleData);
        return redirect()->back()->with('success', 'User created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {
        return Inertia::render('User/Show', [
            'user' => $user,
        ]);
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
            'password' => 'nullable',
            'is_available' => 'required',
            'warehouse_id' => $this->generalSettingRepository->checkIfSettingIsActivated('Warehouse') ? 'required' : 'nullable',
            'route_id' => $this->generalSettingRepository->checkIfSettingIsActivated('Routes') ? 'required' : 'nullable',
            'truck_id' => $this->generalSettingRepository->checkIfSettingIsActivated('Trucks') ? 'required' : 'nullable',
            'address' => 'required',
            'company_id' => 'nullable',
            'type' => 'required',
        ]);

        $this->userRepository->updateUser($data, $user->id);
        return redirect()->back()->with('success', 'User updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        $this->userRepository->deleteUser($user->id);
        return redirect()->back()->with('success', 'User deleted successfully');
    }

    public  function profile()
    {
        return Inertia::render('Profile');
    }

    public function filter(Request $request)
    {
        $first_name = $request->first_name;
        $last_name = $request->last_name;
        $phone_number = $request->phone_number;
        $email = $request->email;
        $role = $request->role;

        $users = $this->userRepository->filter($first_name, $last_name, $phone_number, $email, $role);

        return $users;
    }


    //mobile functions

    //driver login
    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required',
            'password' => 'required',
        ]);

        $device = $request->validate([
            'device_name' => 'required',
        ]);

        $user = $this->userRepository->login($data);
        if ($user) {
            $token = $user->createToken($device['device_name'])->plainTextToken;
            return $this->response('Login successful', ['token' => $token]);
        } else {
            return $this->response('Invalid credentials', null, 401);
        }
    }

    //get authenticated user
    public function getAuthenticatedUser()
    {
        $user = $this->userRepository->profile();
        return $this->response('User profile', $user);
    }

    //update user profile
    public function updateProfile(Request $request)
    {
        $data = $request->validate([
            'first_name' => 'required',
            'last_name' => 'required',
            'phone_number' => 'required',
            'email' => 'required',
        ]);

        $user = $this->userRepository->updateUser($data, auth()->user()->id);
        return $this->response('User profile updated', $user);
    }


    //change password
    public function changePassword(Request $request)
    {
        $data = $request->validate([
            'old_password' => 'required',
            'password' => 'required|confirmed',
        ]);
        $user = $this->userRepository->changePassword($data);
        if ($user) {
            return $this->response('Password changed successfully', $user);
        } else {
            return $this->response('Invalid old password', null, 401);
        }
    }
}
