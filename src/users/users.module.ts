import { AuthService } from './../auth/auth.service';
import { Global, Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UserSchema } from 'src/schemas/user';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { jwtConstants } from 'src/auth/passport/constants';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from 'src/auth/jwt/jwt.strategy';


@Global()
@Module({
  providers: [UsersService,JwtStrategy],
  exports: [UsersService],
  imports: [MongooseModule.forFeature([{ name: 'User', schema: UserSchema }]), JwtModule.register({
    secret: jwtConstants.secret,
    // signOptions: { expiresIn: '1200s' },
  })],
  controllers: [UsersController],
})
export class UsersModule { }
