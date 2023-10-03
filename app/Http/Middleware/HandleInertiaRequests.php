<?php

namespace App\Http\Middleware;

use App\Interfaces\CurrencyRepositoryInterface;
use App\Interfaces\PricingMethodRepositoryInterface;
use Illuminate\Http\Request;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    private CurrencyRepositoryInterface $currencyRepository;
    private PricingMethodRepositoryInterface $pricingMethodRepository;

    public function __construct(CurrencyRepositoryInterface $currencyRepository, PricingMethodRepositoryInterface $pricingMethodRepository)
    {
        $this->currencyRepository = $currencyRepository;
        $this->pricingMethodRepository = $pricingMethodRepository;
    }
    /**
     * The root template that's loaded on the first page visit.
     *
     * @see https://inertiajs.com/server-side-setup#root-template
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determines the current asset version.
     *
     * @see https://inertiajs.com/asset-versioning
     * @param  \Illuminate\Http\Request  $request
     * @return string|null
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Defines the props that are shared by default.
     *
     * @see https://inertiajs.com/shared-data
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function share(Request $request): array
    {
        return array_merge(parent::share($request), [
            'roles' => fn () => auth()->check() ? $request->user()->getRoleNames() : [],
            'permissions' => fn () => auth()->check() ? $request->user()->getPermissionsViaRoles()->pluck('name') : [],
            'error' => fn () => $request->session()->get('error'),
            'success' => fn () => $request->session()->get('success'),
            'defaultCurrency' => fn () => auth()->check() ? $this->currencyRepository->getDefaultCurrency() : null,
            'currencies' => fn () => auth()->check() ? $this->currencyRepository->all() : [],
            'defaultPricingMethod' => fn () => auth()->check() ? $this->pricingMethodRepository->getDefaultPricingMethod() : null,
        ]);
    }
}
