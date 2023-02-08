import { CreateWarehouseDto } from './../dto/warehouse';
import { Body, Controller, Delete, Param, Post, Res, UseGuards, Get } from '@nestjs/common';
import { RolesGuard } from 'src/auth/guards/role';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { Roles } from 'src/decorators/role';
import Role from 'src/enums/role';
import { successResponse } from 'src/response/success';
import { WarehouseService } from './warehouse.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';


@ApiBearerAuth()
@ApiTags('Warehouse')
@Controller('warehouse')
export class WarehouseController {

    constructor(private warehouseService: WarehouseService) { }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Post('create')
    async createNewWarehouse(@Body() createWasehouse: CreateWarehouseDto, @Res() res) {
        return successResponse(res, 201, "Warehouse created", await this.warehouseService.create(createWasehouse));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Post('update/:id')
    async updateWarehouse(@Body() createWasehouse: CreateWarehouseDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Warehouse updated", await this.warehouseService.update(id, createWasehouse));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Delete('delete/:id')
    async deleteWarehouse(@Res() res, @Param('id') id: string) {
        return successResponse(res, 200, "Warehouse deleted", await this.warehouseService.delete(id));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Get('get-all')
    async getAllWarehouses(@Res() res) {
        return successResponse(res, 200, "All warehouses", await this.warehouseService.findAll());
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Get('get/:id')
    async getWarehouse(@Res() res, @Param('id') id: string) {
        return successResponse(res, 200, "Warehouse", await this.warehouseService.findOne(id));
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Roles(Role.Admin)
    @Get('get-paginated')
    async getPaginatedWarehouses(@Res() res, @Param('page') page: number, @Param('limit') limit: number) {
        return successResponse(res, 200, "Paginated warehouses", await this.warehouseService.getPaginatedWarehouses(page, limit));
    }

}
