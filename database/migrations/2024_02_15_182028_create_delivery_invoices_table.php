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
        Schema::create('delivery_invoices', function (Blueprint $table) {
            $table->id();
            $table->foreignId('delivery_id')->constrained('deliveries');
            $table->string('invoice_number');
            $table->enum('status', ['Pending', 'Canceled', 'Paid']);

            $table->json('discount')->nullable();
            $table->json('tax')->nullable();
            $table->json('totals')->nullable();

            $table->string('customer_signature')->nullable();
            $table->string('driver_signature')->nullable();
            $table->string('receipt_url')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('delivery_invoices');
    }
};
