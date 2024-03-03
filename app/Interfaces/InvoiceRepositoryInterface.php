<?php

namespace App\Interfaces;

interface InvoiceRepositoryInterface
{

    //get delivery sheet by status
    public function getPaginated(int $n);

    public function syncInvoices(array $default, array $invoices);

    public function filter($customer, $status,$type, $from, $to,$invoice_number, $delivery, $loadsheet, $branch);

    public function companyTotalIncome($from = null, $to = null);

    public function  companyInvoices($from = null, $to =null);

}
