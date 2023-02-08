import * as mongoose from 'mongoose';

export const ProductSchema = new mongoose.Schema({
    name: { type: String, required: true },
    code: { type: String, required: true },
    wholesale_price: { type: Number, required: true },
    retail_price: { type: Number, required: true },
    units_on_hand: { type: Number, default: 0 },
    isReturnable: { type: Boolean, default: false },
    category: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Category'
    },
    tax_code: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'TaxCode'
    },
    unit_measure: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'UnitMeasure'
    },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

export const CategorySchema = new mongoose.Schema({
    name: { type: String, required: true },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

export const TaxCodeSchema = new mongoose.Schema({
    name: { type: String, required: true },
    rate: { type: Number, required: true },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

export const UnitMeasureSchema = new mongoose.Schema({
    name: { type: String, required: true },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

