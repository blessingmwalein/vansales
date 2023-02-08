import * as mongoose from 'mongoose';

export const WarehouseSchema = new mongoose.Schema({
    name: { type: String, required: true },
    code: { type: String, required: true },
    allocated_stock: { type: Number, default: 0 },
    lat: { type: String, required: true },
    lon: { type: String, required: true },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});
