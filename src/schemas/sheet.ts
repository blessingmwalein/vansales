import mongoose from "mongoose";
import { UserSchema } from "./user";
import SheetStatus from "src/enums/sheet_status";
import { RouteSchema } from "./route";
import { TruckSchema } from "./truck";

export const SheetSchema = new mongoose.Schema({
    number: { type: String, required: true },
    driver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    status: {
        type: String,
        enum: Object.values(SheetStatus),
        default: SheetStatus.CREATED,
    },
    route: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Route'
    },
    truck: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Truck'
    },
    warehouse: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Warehouse'
    },
    allocated_stock: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'SheetAllocation'
    }],
    invoices: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Invoice'
    }],
    start_date_time: { type: Date, default: Date.now },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});