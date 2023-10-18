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
        Schema::create('loadsheets', function (Blueprint $table) {
            $table->id();
            $table->string('loadsheet_number');
            $table->foreignId('user_id')->constrained('users');
            $table->foreignId('truck_id')->constrained('trucks');
            $table->foreignId('warehouse_id')->nullable()->constrained('warehouses');
            $table->enum('status', ['Draft', 'Created', 'Loaded', 'Confirmed','Started', 'Completed']);
            $table->foreignId('route_id')->constrained('routes');
            $table->string('start_date_time')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('loadsheets');
    }
};
