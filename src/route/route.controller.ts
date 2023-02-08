import { CreateRouteDto } from './../dto/route';
import { RouteService } from './route.service';
import { Body, Controller, Delete, Get, Param, Post, Res, UseGuards, Put } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { RolesGuard } from 'src/auth/guards/role';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { Roles } from 'src/decorators/role';
import Role from 'src/enums/role';
import { successResponse } from 'src/response/success';


@ApiBearerAuth()
@ApiTags('Route')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(Role.Admin)
@Controller('route')
export class RouteController {
    constructor(
        private routeService: RouteService
    ) { }

    @Post('create')
    async createRoute(@Body() createRouteDto: CreateRouteDto, @Res() res) {
        return successResponse(res, 201, "Route Created", await this.routeService.create(createRouteDto));
    }

    @Put('update/:id')
    async updateRoute(@Body() createRouteDto: CreateRouteDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Route updated", await this.routeService.update(id, createRouteDto));
    }

    @Delete('delete/:id')
    async deleteRoute(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Route deleted", await this.routeService.remove(id));
    }

    @Get('getAllRoutes')
    async getAllRoutes(@Res() res) {
        return successResponse(res, 201, "Routes", await this.routeService.findAll());
    }

    @Get('getOneRoute/:id')
    async getOneRoute(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Route", await this.routeService.findOne(id));
    }





}
