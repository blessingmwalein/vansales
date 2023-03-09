import { Body, Controller, Delete, Get, Param, Post, Put, Res, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { RolesGuard } from 'src/auth/guards/role';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { Roles } from 'src/decorators/role';
import Role from 'src/enums/role';
import { TruckService } from './truck.service';
import { successResponse } from 'src/response/success';
import { CreateTruckDto } from 'src/dto/truck';

@ApiBearerAuth()
@ApiTags('Truck')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(Role.Admin)
@Controller('truck')
export class TruckController {
    constructor(
        private truckService: TruckService
    ) { }

    @Post('create')
    async createRoute(@Body() createTruckDto: CreateTruckDto, @Res() res) {
        return successResponse(res, 201, "Truck Created", await this.truckService.create(createTruckDto));
    }

    @Put('update/:id')
    async updateRoute(@Body() createTruckDto: CreateTruckDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Truck updated", await this.truckService.update(id, createTruckDto));
    }

    @Delete('delete/:id')
    async deleteRoute(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Truck deleted", await this.truckService.remove(id));
    }

    @Get('getAllTrucks')
    async getAllTrucks(@Res() res) {
        return successResponse(res, 201, "Trucks", await this.truckService.findAll());
    }

    @Get('getOneTruck/:id')
    async getOneTruck(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Truck", await this.truckService.findOne(id));
    }
}
