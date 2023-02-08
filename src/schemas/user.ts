import * as mongoose from 'mongoose';
import Role from 'src/enums/role';
import UserStatus from 'src/enums/user_status';

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
});
