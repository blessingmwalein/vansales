<?php

namespace App\Policies;

use App\Models\User;

class LoadSheetPolicy
{
    /**
     * Create a new policy instance.
     */
    public function __construct()
    {
        //
    }

    public function viewHistory($user, $loadSheet)
    {
        return $user->isAdmin() || $user->hasRole('security');
    }
}
