import * as mongoose from 'mongoose';

export const StockAllocationSchema = new mongoose.Schema({
    units_allocated: { type: Number, default: 0 },
    product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product'
    },
    warehouse: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Warehouse'
    },
    allocatedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});
