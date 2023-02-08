import Role from 'src/enums/role';
import UserStatus from 'src/enums/user_status';

export class User {
  _id: string;
  first_name: string;
  last_name: string;
  email: string;
  title: string;
  phone_number: string;
  password: string;
  create_at: Date;
  updated_at: Date;
  status: UserStatus;
  role: Role;
}
