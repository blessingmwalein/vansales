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
            return redirect()->to('/dashboard');
        } else if ($request->user()->hasRole('security')) {
            return redirect()->to('/dashboard/security');
        } else {
            return Inertia::location('/');
        }
    }
}
