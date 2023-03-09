import * as mongoose from 'mongoose';
import Role from 'src/enums/role';
import UserStatus from 'src/enums/user_status';
import { PointSchema } from './route';

export const UserSchema = new mongoose.Schema({
  first_name: { type: String, required: true },
  last_name: { type: String, required: true },
  email: { type: String, required: false },
  title: { type: String, required: false },
  phone_number: { type: String, required: true },
  password: { type: String, required: true },
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now },
  status: {
    type: String,
    enum: Object.values(UserStatus),
    default: UserStatus.ACTIVE,
  },
  role: {
    type: String,
    enum: Object.values(Role),
  },
  customer_details: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'CustomerDetails'
},
});

export const CustomerDetailsSchema = new mongoose.Schema({
  company: { type: String, required: false },
  address: { type: String, required: false },
  location: {
    type: PointSchema,
    required: true
  },
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now },
});


