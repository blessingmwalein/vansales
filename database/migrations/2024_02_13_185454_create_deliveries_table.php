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
        Schema::create('deliveries', function (Blueprint $table) {
            $table->id();
            $table->foreignId('delivery_sheet_id')->constrained('delivery_sheets');
            $table->foreignId('customer_id')->nullable()->constrained('customers');
            $table->foreignId('company_id')->nullable()->constrained('companies')->onDelete('cascade');
            $table->enum('status', ['Draft', 'Pending', 'Delivered', 'Cancelled', 'Returned']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('deliveries');
    }
};
