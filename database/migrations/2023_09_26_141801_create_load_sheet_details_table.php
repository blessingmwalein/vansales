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
        Schema::create('load_sheet_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('load_sheet_id')->constrained('loadsheets');
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
        Schema::dropIfExists('load_sheet_details');
    }
};
