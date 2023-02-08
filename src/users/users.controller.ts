import Role  from 'src/enums/role';
import UserStatus from 'src/enums/user_status';
import { AuthDto } from './../dto/auth';
import { Body, Controller, Post, Res, Request, Param, Get, Put, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { CreateUserDto } from 'src/dto/user';
import { successResponse } from 'src/response/success';
import { UsersService } from './users.service';
import { errorResponse } from 'src/response/error';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { RolesGuard } from 'src/auth/guards/role';
import { Roles } from 'src/decorators/role';


@ApiBearerAuth()
@ApiTags('User')
@Controller('users')
export class UsersController {

    constructor(private usersService: UsersService) {

    }


    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Post('create')
    async createNewUser(@Body() createUserDto: CreateUserDto, @Res() res) {
        return successResponse(res, 201, "User created", await this.usersService.createNewUser(createUserDto));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Put('update/:id')
    async updateUser(@Body() createUserDto: CreateUserDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "User updated", await this.usersService.updateUser(id, createUserDto));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Post('delete/:id')
    async deleteUser(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "User deleted", await this.usersService.deleteUser(id));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Post('update-status/:id')
    async updateUserStatus(@Res() res, @Request() req, @Param('id') id: string) {
        return successResponse(res, 201, "User status updated", await this.usersService.updateUserStatus(id, req.status));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Post('update-role/:id')
    async updateUserRole(@Res() res, @Request() req, @Param('id') id: string) {
        return successResponse(res, 201, "User role updated", await this.usersService.updateUserRole(id, req.role));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Post('update-password/:id')
    async updateUserPassword(@Res() res, @Request() req, @Param('id') id: string) {
        return successResponse(res, 201, "User password updated", await this.usersService.changePassword(id, req.password));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Get('get/:id')
    async getUser(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "User fetched", await this.usersService.findUserById(id));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Get('get-all')
    async getAllUsers(@Res() res) {
        return successResponse(res, 201, "Users fetched", await this.usersService.getAllUsers());
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Get('filter-by-status/:status')
    async filterUsersByStatus(@Res() res, @Param('status') status: UserStatus) {
        return successResponse(res, 201, "Users fetched", await this.usersService.filterUsersByStatus(status));
    }

    


}
