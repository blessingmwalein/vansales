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
        Schema::create('allocation_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('delivery_id')->nullable()->constrained('deliveries');
            $table->foreignId('loadsheet_id')->nullable()->constrained('loadsheets');
            $table->foreignId('stock_id')->constrained('stocks');
            $table->float('quantity');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('allocation_items');
    }
};
