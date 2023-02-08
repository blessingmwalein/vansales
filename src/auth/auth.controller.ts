import { AuthService } from './auth.service';
import { Body, Controller, HttpException, Post, Res } from '@nestjs/common';
import { AuthDto } from 'src/dto/auth';
import { errorResponse } from 'src/response/error';
import { successResponse } from 'src/response/success';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';


@ApiBearerAuth()
@ApiTags('Auth')
@Controller('auth')
export class AuthController {

    constructor(private readonly authService: AuthService) { }


    @Post('login')
    async login(@Res() res, @Body() authDto: AuthDto) {

        console.log(authDto)
        const result: any = await this.authService.login(authDto)
        if (result instanceof HttpException) {
            return errorResponse(res, 422, result.message, []);
        }
        return successResponse(res, 200, `Login Success`, result)
    }
}
