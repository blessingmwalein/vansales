<?php

namespace App\Exports;

use App\Models\LoadSheetDetail;
use App\Models\LoadSheetDetails;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;


class LoadSheetDetailsExport implements FromCollection, WithHeadings
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
        // Load the LoadSheetDetail records with the associated Stock information
        return LoadSheetDetail::where('load_sheet_id', $this->loadsheetId)
            ->with('stock') // Assuming the relationship is named 'stock'
            ->get()
            ->map(function ($item) {
                return [
                    'ID' => $item->id,
                    'Load Sheet Id' => $item->load_sheet_id,
                    'Stock Name' => $item->stock->product->description, // Access the stock name
                    'Code' => $item->stock->product->code, // Access the stock name
                    'Quantity' => $item->quantity,
                    'Created At' => $item->created_at,
                    'Updated At' => $item->updated_at,
                ];
            });
    }

    public function headings(): array
    {
        // Define your headings here
        return [
            'ID',
            'Load Sheet Id',
            'Stock Name', // Change to 'Stock Id' if you want to display the stock ID
            'Code', // Change to 'Stock Id' if you want to display the stock ID
            'Quantity',
            'Created At',
            'Updated At',
        ];
    }
}
