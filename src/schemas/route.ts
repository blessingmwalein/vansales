import * as mongoose from 'mongoose';

export const PointSchema = new mongoose.Schema({
    type: {
        type: String,
        enum: ['Point'],
        required: true
    },
    coordinates: {
        type: [Number],
        required: true
    }
});
export const RouteSchema = new mongoose.Schema({
    name: { type: String, required: true },
    code: { type: String, required: true },
    origin: {
        type: PointSchema,
        required: true
    },
    destination: {
        type: PointSchema,
        required: true
    },
    waypoints: {
        type: [PointSchema],
        required: true
    },
    average_distance: { type: Number, required: true },
    average_duration: { type: Number, required: true },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});


