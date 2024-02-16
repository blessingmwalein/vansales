<?php

namespace App\Http\Controllers;

use App\Models\DeliveryInvoice;
use Illuminate\Http\Request;
use App\Interfaces\DeliveryRepositoryInterface;

class DeliveryInvoiceController extends Controller
{

    private DeliveryRepositoryInterface $deliverySheetRepository;


    public function __construct(
        DeliveryRepositoryInterface $deliverySheetRepository
    ) {
        $this->deliverySheetRepository = $deliverySheetRepository;
    }

    public function syncInvoices(Request $request)
    {
        $data = $request->validate([
            'delivery_id' => 'required',
            'invoices' => 'required | array',
            // "invoice_number" => "required",
        ]);

        $this->deliverySheetRepository->syncInvoices($data['delivery_id'], $data['invoices']);

        return $this->response('Invoice Synced', [], 200);
    }
}
