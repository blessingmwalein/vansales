import { AuthService } from './../auth/auth.service';
import { AuthDto } from './../dto/auth';
import UserStatus from 'src/enums/user_status';
import { User } from './../models/user';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { HttpException, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { CreateUserDto } from 'src/dto/user';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
    AppUrl: any;
    users: any;
    constructor(@InjectModel("User") private readonly userModel: Model<User>, private jwtService: JwtService) {

    }


    //get all users
    async getAllUsers(): Promise<User[]> {
        const result = await this.userModel.find({}, { password: 0 });
        return result;
    }

    //filter users by status
    async filterUsersByStatus(status: UserStatus): Promise<User[]> {
        return await this.userModel.find({ status: status }, { password: 0 });
    }

    async findOneByEmail(email: string): Promise<User | undefined> {
        return await this.userModel.findOne({ email: email });
    }

    async findUserById(id: string): Promise<User | undefined> {
        return await this.userModel.findById(id, { password: 0 });
    }

    async createNewUser(user: CreateUserDto): Promise<User> {

        if (await this.userAreadyExists(user.email, user.phone_number)) {
            throw new HttpException('User with Email or phone number already exists', 422);
        }
        //hash password
        user.password = await bcrypt.hash(user.password, 10);
        const newUser = new this.userModel(user);
        const result = await newUser.save();

        return result;
    }

    async updateUser(id: string, user: CreateUserDto): Promise<User> {
        const result = await this.userModel.findByIdAndUpdate(id, user);
        return result;
    }

    async deleteUser(id: string): Promise<User> {
        const result = await this.userModel.findByIdAndDelete(id);
        return result;
    }

    //update user status
    async updateUserStatus(id: string, status: UserStatus): Promise<User> {
        const user = this.userModel.findByIdAndUpdate(id, { status: status }, {
            new: true
        });
        return user;
    }

    //update user role
    async updateUserRole(id: string, role: string): Promise<User> {
        const user = this.userModel.findByIdAndUpdate(id, { role: role }, {
            new: true
        });
        return user;
    }

    //change password
    async changePassword(id: string, password: string): Promise<User> {
        const user = this.userModel.findByIdAndUpdate(id, { password: await bcrypt.hash(password, 10) }, {
            new: true
        });
        return user;
    }

    //check if user already exists
    async userAreadyExists(email: string, phone_number: string): Promise<boolean> {
        const user = await this.userModel.findOne({ $or: [{ email: email }, { phone_number: phone_number }] });
        if (user) {
            return true;
        }
        return false;
    }

    decodeToken(token: string) {
        return this.jwtService.decode(token);
    }
}

