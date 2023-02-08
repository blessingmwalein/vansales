import { CreateStockAllocationDto, TransferStockDto } from './../dto/stock-allocation';
import { Controller, UseGuards, Post, Body, Res, Delete, Param, Get } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { RolesGuard } from 'src/auth/guards/role';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { Roles } from 'src/decorators/role';
import { CreateCategoryDto } from 'src/dto/product';
import Role from 'src/enums/role';
import { successResponse } from 'src/response/success';
import { StockAllocationService } from './stock-allocation.service';


@ApiBearerAuth()
@ApiTags('StockAllocation')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(Role.Admin)
@Controller('stock-allocation')
export class StockAllocationController {

    constructor(private readonly stockAllocationService: StockAllocationService) { }

    @Post('stock-allocation/create')
    async createCategory(@Body() createStockAllocationDto: CreateStockAllocationDto, @Res() res) {
        return successResponse(res, 201, "Stock Allocated", await this.stockAllocationService.create(createStockAllocationDto));
    }

    @Post('stock-allocation/update/:id')
    async updateCategory(@Body() createStockAllocationDto: CreateStockAllocationDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Stock Allocation updated", await this.stockAllocationService.update(id, createStockAllocationDto));
    }

    @Delete('stock-allocation/delete/:id')
    async deleteCategory(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Stock Allocation deleted", await this.stockAllocationService.remove(id));
    }

    //get all categories
    @Get('stock-allocation/getAllStockAllocations')
    async getAllCategories(@Res() res) {
        return successResponse(res, 201, "Stock Allocations", await this.stockAllocationService.findAll());
    }

    //get one category
    @Get('stock-allocation/getOneStockAllocation/:id')
    async getOneCategory(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Stock Allocation", await this.stockAllocationService.findOne(id));
    }

    //get by warehouse
    @Get('stock-allocation/getByWarehouse/:id')
    async getByWarehouse(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Stock Allocation", await this.stockAllocationService.findByWarehouse(id));
    }

    //get by product

    @Get('stock-allocation/getByProduct/:id')
    async getByProduct(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Stock Allocation", await this.stockAllocationService.findByProduct(id));
    }

    //transfer stock from one warehouse to another
    @Post('stock-allocation/transferStock/:id')
    async transferStock(@Body() transferStockDto: TransferStockDto, @Res() res) {
        return successResponse(res, 201, "Stock Allocated", await this.stockAllocationService.transferStock(transferStockDto));
    }


    //bulk stock stock transfer from one warehouse to another
    @Post('stock-allocation/bulkTransferStock')
    async bulkTransferStock(@Body() transferStockDto: TransferStockDto[], @Res() res) {
        return successResponse(res, 201, "Stock Allocated", await this.stockAllocationService.bulkTransferStock(transferStockDto));
    }

}
