<?php

namespace App\Repositories;

use App\Interfaces\UserRepositoryInterface;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class UserRepository implements UserRepositoryInterface
{
    public function getAllUsers()
    {
        return User::all();
    }

    public function getAllAdminUsers(
        $from = null,
        $to = null
    ) {

        $query = User::query();

        if ($from && $to) {
            $query->whereBetween('created_at', [$from, $to]);
        }
        return $query->whereHas('roles', function ($query) {
            $query->where('name', 'admin');
        })->get();
    }


    public function getAllUsersPaginated($page = 10)
    {
        return User::latest()->with('roles')->paginate($page);
    }

    public function createUser(array $userData, array $roleData)
    {
        $userData['password'] = bcrypt($userData['password']);
        $user = User::create($userData);
        $role = Role::find($roleData['role_id']);
        $user->assignRole($role);
        return $user;
    }

    public function updateUser(array $data, $id)
    {
        $user = User::find($id);

        $userRole = $data['role_id'];

        unset($data['role_id']);

        // Check if the password is set and not empty.
        if (isset($data['password']) && !empty($data['password'])) {
            $data['password'] = bcrypt($data['password']);
        } else {
            // If the password is not provided in the input data, don't update it.
            unset($data['password']);
        }
        $user->update($data);
        return $user;
    }


    public function deleteUser($id)
    {
        $user = User::find($id);
        //detach all roles
        $user->roles()->detach();
        //delete user
        return $user->delete();
    }

    public function filter($first_name, $last_name, $phone_number, $email, $role)
    {
        $users = User::query();

        if ($first_name) {
            $users->where('first_name', 'LIKE', "%{$first_name}%");
        }

        if ($last_name) {
            $users->where('last_name', 'LIKE', "%{$last_name}%");
        }

        if ($phone_number) {
            $users->where('phone_number', 'LIKE', "%{$phone_number}%");
        }

        if ($email) {
            $users->where('email', 'LIKE', "%{$email}%");
        }

        if ($role) {
            $users->whereHas('roles', function ($query) use ($role) {
                $query->where('id', $role);
            });
        }

        return $users->with('roles')->paginate(10);
    }

    //login
    public function login(array $data)
    {
        $user = User::where('email', $data['email'])->first();


        if ($user) {
            if (auth()->attempt($data)) {
                return $user;
            }
        }
        return false;
    }

    //user profile
    public function profile()
    {
        //get user authenticaed user with roles
        return User::with('roles')->find(auth()->user()->id);
    }

    //change password
    public function changePassword(array $data)
    {
        $user = User::find(auth()->user()->id);

        //check if old password is correct
        if (!Hash::check($data['old_password'], $user->password)) {
            return false;
        }
        $user->password = bcrypt($data['password']);
        return $user->save();
    }
}
