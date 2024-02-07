<?php

namespace App\Exports;

use App\Models\Loadsheet;
use App\Models\SaleOrderDetail;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class LoadSheetSummaryExport implements FromCollection, WithHeadings
{
    protected $loadsheetId;

    public function __construct($loadsheetId)
    {
        $this->loadsheetId = $loadsheetId;
    }

    /**
     * @return \Illuminate\Support\Collection
     */
    public function collection()
    {
        $loadSheet = Loadsheet::find($this->loadsheetId);
        // Retrieve SaleOrderDetail records for the specific loadsheet
        $details = $loadSheet->getSalesOrderDetails();

        //convert to collection
        $details = collect($details);
        // dd($details);

        //map the collection
        $details = $details->map(function ($item) {
            return [
                'ID' => $item->id,
                'Sale Order Id' => $item->sale_order_id,
                'Stock Id' => $item->stock_id,
                'Stock Name' => $item->stock->product->description, // Access the stock name
                'Stock Code' => $item->stock->product->code, // Access the stock name
                'Quantity' => $item->quantity,
                'Total' => $item->total_price,
                'Created At' => $item->created_at,
                'Updated At' => $item->updated_at,
            ];
        });

        return $details;
    }

    /**
     * Add headings to the exported file
     *
     * @return array
     */
    public function headings(): array
    {
        // Define your headings here
        return [
            'ID',
            'Sale Order Id',
            'Stock Id',
            'Stock Name',
            'Stock Code',
            'Quantity',
            'Total',
            'Created At',
            'Updated At',
        ];
    }
}
