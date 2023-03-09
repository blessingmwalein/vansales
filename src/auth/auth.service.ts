import { map } from 'rxjs/operators';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { AuthDto } from 'src/dto/auth';
import { User } from 'src/models/user';
import { UsersService } from 'src/users/users.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
    constructor(
        private usersService: UsersService,
        private jwtService: JwtService,
    ) {

    }

    async validateUser(authDto: AuthDto): Promise<User | undefined> {
        const user = await this.usersService.findOneByEmail(authDto.email);
        if (user) {
            return user;
        }
        return null;
    }

    async login(user: AuthDto) {
        const validatedUser = await this.validateUser(user);
        if (validatedUser) {
            var passwordMatch = await bcrypt.compare(user.password, validatedUser.password);
            if (!passwordMatch || validatedUser.email !== user.email) {
                return new UnauthorizedException("Credentials do not match our records");
            }
            return {
                access_token: this.jwtService.sign(
                    {
                        _id: validatedUser._id,
                        email: validatedUser.email,
                        phone_number: validatedUser.phone_number
                    }
                ),
                user: {
                    _id: validatedUser._id,
                    email: validatedUser.email,
                    phone_number: validatedUser.phone_number,
                    first_name: validatedUser.first_name,
                    last_name: validatedUser.last_name,
                    title: validatedUser.title,
                    role: validatedUser.role,
                    status: validatedUser.status,
                    create_at: validatedUser.created_at,
                    updated_at: validatedUser.updated_at
                }
            };
        }
        return new UnauthorizedException('Credentials do not match our records');

    }
}
