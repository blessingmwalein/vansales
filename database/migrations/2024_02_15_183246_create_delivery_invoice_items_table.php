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
        Schema::create('delivery_invoice_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('delivery_invoice_id')->constrained('delivery_invoices');
            $table->foreignId('stock_id')->constrained('stocks');
            $table->float('quantity');
            $table->float('total_price');
            $table->foreignId('currency_id')->nullable()->constrained('currencies');
            $table->boolean('is_synced')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('delivery_invoice_items');
    }
};
