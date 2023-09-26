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
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('code');
            $table->text('description');
            $table->foreignId('product_category_id')->constrained('product_categories');
            $table->float('reorder_level');
            $table->string('image')->nullable();
            $table->foreignId('tax_id')->constrained('taxes');
            $table->foreignId('unit_measure_id')->constrained('unit_measures');
            $table->float('discount')->nullable();
            $table->float('retail_unit_price')->nullable();
            $table->float('wholesale_unit_price')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
