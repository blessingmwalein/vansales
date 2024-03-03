<?php

namespace App\Http\Controllers;

use App\Http\Resources\SaleOderDetailResource;
use App\Interfaces\CompanyRepositoryInterface;
use App\Interfaces\InvoiceRepositoryInterface;
use App\Interfaces\SubscriptionRepositoryInterface;
use App\Interfaces\UserRepositoryInterface;
use App\Models\Product;
use App\Models\SaleOrder;
use App\Models\SaleOrderDetail;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Symfony\Component\HttpKernel\HttpCache\Ssi;

class DashboardController extends Controller
{
    private CompanyRepositoryInterface  $companyRepository;
    private SubscriptionRepositoryInterface $subscriptionRepository;
    private UserRepositoryInterface $userRepository;
    private InvoiceRepositoryInterface $invoiceRepository;

    public function __construct(
        CompanyRepositoryInterface $companyRepository,
        SubscriptionRepositoryInterface $subscriptionRepository,
        UserRepositoryInterface $userRepository,
        InvoiceRepositoryInterface $invoiceRepository
    ) {
        $this->companyRepository = $companyRepository;
        $this->subscriptionRepository = $subscriptionRepository;
        $this->userRepository = $userRepository;
        $this->invoiceRepository = $invoiceRepository;
    }
    public function index()
    {
        // $topProducts = SaleOrderDetail::select('stock_id')
        //     ->selectRaw('SUM(quantity) as total_quantity, SUM(total_price) as total_price')
        //     ->groupBy('stock_id')
        //     ->orderByDesc('total_quantity')
        //     ->limit(5)
        //     ->get();
        // //get news users added for the current quarter
        // $newUsers = User::whereBetween('created_at', [Carbon::now()->startOfQuarter(), Carbon::now()->endOfQuarter()])
        //     ->count();

        // //number new products added for the current quarter
        // $newProducts = Product::whereBetween('created_at', [Carbon::now()->startOfQuarter(), Carbon::now()->endOfQuarter()])
        //     ->count();

        // //% increase of products added for the current quarter with respect to the previous quarter
        // $previousQuarter = Carbon::now()->subQuarter(1);
        // $previousQuarterProducts = Product::whereBetween('created_at', [$previousQuarter->startOfQuarter(), $previousQuarter->endOfQuarter()])
        //     ->count();

        // $percentageIncrease = 0;
        // if ($previousQuarterProducts > 0) {
        //     $percentageIncrease = (($newProducts - $previousQuarterProducts) / $previousQuarterProducts) * 100;
        // }


        // //get sales for the current year in a monthly basis
        // $sales = SaleOrder::selectRaw('MONTH(created_at) as month, SUM(total) as total')
        //     ->whereYear('created_at', Carbon::now()->year)
        //     ->groupBy('month')
        //     ->get();

        // // dd($sales);
        // //total sales for the current year
        // $totalSales = SaleOrder::whereYear('created_at', Carbon::now()->year)->sum('total');

        return Inertia::render(
            'Dashboard',
            [
                'employees' => $this->companyRepository->getEmployees()->count(),
                'newEmployees' => $this->companyRepository->getEmployees(
                    Carbon::now()->startOfMonth(),
                    Carbon::now()->endOfMonth()
                )->count(),
                'totalEarnings' => $this->invoiceRepository->companyTotalIncome(),
                'totalEarningsThisMonth' => $this->invoiceRepository->companyTotalIncome(
                    Carbon::now()->startOfMonth(),
                    Carbon::now()->endOfMonth()
                ),
                'totalInvoices' => $this->invoiceRepository->companyInvoices()->count(),
                'newInvoices' => $this->invoiceRepository->companyInvoices(
                    Carbon::now()->startOfMonth(),
                    Carbon::now()->endOfMonth()
                )->count(),
            ]
            // [
            //     'topSoldProducts' => SaleOderDetailResource::collection($topProducts),
            //     'newUsers' => $newUsers,
            //     'newProducts' => $newProducts,
            //     'percentageIncrease' => $percentageIncrease,
            //     'sales' => $sales,
            //     'totalSales' => $totalSales
            // ]

        );
    }

    public function admin()
    {
        return Inertia::render(
            'AdminDashboard',
            [
                'companies' => $this->companyRepository->getAllCompanies()->count(),
                'newCompanies' => $this->companyRepository->getAllCompanies(
                    Carbon::now()->startOfMonth(),
                    Carbon::now()->endOfMonth()
                )->count(),
                'subscriptions' => $this->subscriptionRepository->all()->count(),
                'companySubscriptions' => $this->subscriptionRepository->getCompanySubscriptions()->count(),
                'users' => $this->userRepository->getAllAdminUsers()->count(),
                'newUsers' => $this->userRepository->getAllAdminUsers(
                    Carbon::now()->startOfMonth(),
                    Carbon::now()->endOfMonth()
                )->count(),
            ]
        );
    }
}
