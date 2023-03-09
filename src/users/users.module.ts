import { AuthService } from './../auth/auth.service';
import { Global, Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { jwtConstants } from 'src/auth/passport/constants';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from 'src/auth/jwt/jwt.strategy';
import { CustomerDetails } from 'src/models/user';
import { CustomerDetailsSchema, UserSchema } from 'src/schemas/user';


@Global()
@Module({
  providers: [UsersService,JwtStrategy],
  exports: [UsersService],
  imports: [MongooseModule.forFeature([
    { name: 'User', schema: UserSchema },
    { name: 'CustomerDetails', schema: CustomerDetailsSchema}
  
  ]), JwtModule.register({
    secret: jwtConstants.secret,
    // signOptions: { expiresIn: '1200s' },
  })],
  controllers: [UsersController],
})
export class UsersModule { }
