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
        Schema::create('sale_orders', function (Blueprint $table) {
            $table->id();
            $table->string('order_number');
            $table->foreignId('customer_id')->nullable()->constrained('customers');
            $table->foreignId('loadsheet_id')->nullable()->constrained('loadsheets');
            $table->enum('status', ['Pending', 'Canceled', 'Paid']);
            //currency
            // $table->foreignId('currency_id')->nullable();
            $table->json('discount')->nullable();
            $table->json('tax')->nullable();
            // $table->double('total')->nullable();
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
        Schema::dropIfExists('sale_orders');
    }
};
