<?php

namespace App\Http\Controllers;

use App\Http\Resources\InvoiceItemResource;
use App\Http\Resources\InvoiceResource;
use App\Interfaces\BranchRepositoryInterface;
use App\Interfaces\InvoiceRepositoryInterface;
use App\Models\Invoice;
use Illuminate\Http\Request;
use Inertia\Inertia;

class InvoiceController extends Controller
{
    private InvoiceRepositoryInterface $invoiceRepository;
    private BranchRepositoryInterface $branchRepository;

    public function __construct(
        InvoiceRepositoryInterface $invoiceRepository,
        BranchRepositoryInterface $branchRepository

    )
    {
        $this->invoiceRepository = $invoiceRepository;
        $this->branchRepository = $branchRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function syncInvoices(Request $request)
    {

        $default = $request->validate([
            'delivery_sheet_id' => 'nullable',
            'loadsheet_id' => 'nullable',
            'branch_id' => 'nullable',
            'type' => 'required',

            // "invoice_number" => "required",
        ]);

        $invoices = $request->validate([
            'invoices' => 'required | array',
        ]);


        $this->invoiceRepository->syncInvoices($default, $invoices['invoices']);

        return $this->response('Invoice Synced', [], 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function index()
    {
       return Inertia::render('Invoice/Index', [
            'invoices' => InvoiceResource::collection($this->invoiceRepository->getPaginated(10)),
            'branches' => $this->branchRepository->all()
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Invoice $invoice)
    {
        return Inertia::render('Invoice/Show', [
            'invoice' => new InvoiceResource($invoice),
            'items' => InvoiceItemResource::collection($invoice->items()->paginate(10))
        ]);
    }

    public function filter(Request $request)
    {
        $customer = $request->customer;
        $status = $request->status;
        // $paymentMethod = $request->paymentMethod;
        $invoice_number = $request->invoice_number;
        // $currency = $request->currency;
        $loadsheet = $request->loadsheet;
        $delivery = $request->delivery;
        $branch = $request->branch;
        $from = $request->from;
        $to = $request->to;
        $type = $request->type;

        $invoices = $this->invoiceRepository->filter($customer, $status,$type, $from, $to,$invoice_number, $delivery, $loadsheet, $branch);
        return InvoiceResource::collection($invoices);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Invoice $invoice)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Invoice $invoice)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Invoice $invoice)
    {
        //
    }
}
