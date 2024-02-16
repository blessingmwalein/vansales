<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('delivery_invoices', function (Blueprint $table) {
            $table->foreignId('delivery_sheet_id')->nullable()->constrained('delivery_sheets');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('delivery_invoices', function (Blueprint $table) {
            //
        });
    }
};
