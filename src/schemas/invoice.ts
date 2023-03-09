import mongoose from "mongoose";
import { UserSchema } from "./user";
import SheetStatus from "src/enums/sheet_status";
import { PointSchema, RouteSchema } from "./route";
import { TruckSchema } from "./truck";
import InvoiceStatus from "src/enums/invoice_status";

export const InvoiceItemSchema = new mongoose.Schema({
    sold_units: { type: Number, required: true },
    product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product'
    },
});
export const InvoiceSchema = new mongoose.Schema({
    number: { type: String, required: true },
    driver: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    customer: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    },
    status: {
        type: String,
        enum: Object.values(InvoiceStatus),
        default: InvoiceStatus.Draft,
    },
    sheet: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Sheet'
    },
    items: {
        type: [InvoiceItemSchema],
        required: true
    },
    location: {
        type: PointSchema,
        required: true
    },
    customer_signature:{type: String, required: false},
    manager_signature:{type: String, required: false},
    total: { type: Number, required: true },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

