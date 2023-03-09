import Role from 'src/enums/role';
import UserStatus from 'src/enums/user_status';
import { Point } from './route';

export class User {
  _id: string;
  first_name: string;
  last_name: string;
  email: string;
  title: string;
  phone_number: string;
  password: string;
  created_at: Date;
  updated_at: Date;
  status: UserStatus;
  role: Role;
  customer_details: CustomerDetails;
}
export class CustomerDetails {
  _id: string;
  company: string;
  address: string;
  location: Point;
}
