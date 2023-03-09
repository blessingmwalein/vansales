import mongoose from "mongoose";
import { ProductSchema } from "./product";
import { SheetSchema } from "./sheet";

export const SheetAllocationSchema = new mongoose.Schema({
    loaded_units: { type: Number, required: true },
    returned_units: { type: Number, required: true },
    units_on_hand: { type: Number, required: true },
    product: { 
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product'
    },
    sheet: { 
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Sheet'
    },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});