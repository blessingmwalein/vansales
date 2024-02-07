<?php

namespace App\Interfaces;

interface UserRepositoryInterface
{
    
    public function getAllUsers();

    public function getAllUsersPaginated($page);

    public function createUser(array $userData, array $roleData);

    public function updateUser(array $data, $id);

    public function deleteUser($id);

    public function filter($first_name, $last_name, $phone_number, $email, $role);

    //login
    public function login(array $data);

    //user profile
    public function profile();


    public function changePassword(array $data);
}
