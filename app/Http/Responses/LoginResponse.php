<?php

namespace App\Http\Responses;

use Laravel\Fortify\Contracts\LoginResponse as LoginResponseContract;
use Inertia\Inertia;

class LoginResponse implements LoginResponseContract
{
    /**
     * @param  $request
     * @return mixed
     */
    public function toResponse($request)
    {

        if ($request->user()->hasRole('admin')) {
            return redirect()->to('/admin/dashboard');
        } else if ($request->user()->hasRole('company_admin')) {
            return redirect()->to('/company/dashboard');
        } else {
            return Inertia::location('/');
        }
    }
}
