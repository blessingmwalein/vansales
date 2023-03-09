/*
https://docs.nestjs.com/controllers#controllers
*/

import { Body, Controller, Delete, Get, Param, Post, Put, Res, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { RolesGuard } from 'src/auth/guards/role';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { Roles } from 'src/decorators/role';
import Role from 'src/enums/role';
import { SheetService } from './sheet.service';
import { CreateSheetDto } from 'src/dto/sheet';
import { successResponse } from 'src/response/success';
import { async } from 'rxjs';
import { SheetAllocationDto, UpdateSheetStatusDto } from 'src/dto/sheet-allocation';



@ApiBearerAuth()
@ApiTags('Sheet')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(Role.Admin)
@Controller('sheet')
export class SheetController {

    constructor(private sheetService:SheetService) { }

    @Post('create')
    async createRoute(@Body() createSheetDto: CreateSheetDto, @Res() res) {
        return successResponse(res, 201, "Sheet Created", await this.sheetService.createSheet(createSheetDto));
    }

    @Put('update/:id')
    async updateRoute(@Body() createSheetDto: CreateSheetDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Sheet updated", await this.sheetService.updateSheet(id, createSheetDto));
    }

    @Delete('delete/:id')
    async deleteRoute(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Sheet deleted", await this.sheetService.deleteSheet(id));
    }

    @Get('getAllSheets')
    async getAllRoutes(@Res() res) {
        return successResponse(res, 201, "Routes", await this.sheetService.findAllSheets());
    }

    @Get('getOneSheet/:id')
    async getOneRoute(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Sheet", await this.sheetService.findOneSheet(id));
    }

    //create route for sheet allocation
    @Post('createSheetAllocation/:sheetId')
    async createSheetAllocation(@Body() createSheetAllocationDto: SheetAllocationDto[], @Res() res, @Param('sheetId') sheetId: string) {
        return successResponse(res, 201, "Sheet Allocation Created", await this.sheetService.allocateProductToSheet(sheetId,createSheetAllocationDto));
    }

    @Post('updateSheetStatus/:sheetId')
    async updateSheetStatus(@Body() updateSheetStatusDto: UpdateSheetStatusDto, @Res() res, @Param('sheetId') sheetId: string) {
        return successResponse(res, 201, "Sheet Status Updated", await this.sheetService.updateSheetStatus(sheetId,updateSheetStatusDto.status));
    }


    @Post('removeProductFromSheet/:sheetId/:productId')
    async removeProductFromSheet( @Res() res, @Param('sheetId') sheetId: string, @Param('productId') productId: string) {
        return successResponse(res, 201, "Product Removed", await this.sheetService.removeProductAllocation(sheetId,productId));
    }

    //create route to close sheet
    @Post('closeSheet/:sheetId')
    async closeSheet( @Res() res, @Param('sheetId') sheetId: string) {
        return successResponse(res, 201, "Sheet Closed", await this.sheetService.closeSheet(sheetId));
    }

    

}
