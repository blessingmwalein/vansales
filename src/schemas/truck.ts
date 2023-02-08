import mongoose from "mongoose";

export const TruckSchema = new mongoose.Schema({
    make: { type: String, required: true },
    reg_number: { type: String, required: true },
    default_driver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    mileage: { type: Number, required: true },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});