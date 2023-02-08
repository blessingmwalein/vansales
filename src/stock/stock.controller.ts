import { StockService } from './stock.service';
import { Body, Controller, Param, Post, Res, UseGuards, Put, Delete, Get } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { UsersService } from 'src/users/users.service';
import { CreateCategoryDto, CreateProductDto, CreateTaxCodeDto, CreateUnitMeasureDto } from 'src/dto/product';
import { successResponse } from 'src/response/success';
import { RolesGuard } from 'src/auth/guards/role';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { Roles } from 'src/decorators/role';
import Role from 'src/enums/role';


@ApiBearerAuth()
@ApiTags('Stock')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(Role.Admin)
@Controller('stock')
export class StockController {

    constructor(private stockService: StockService) {

    }

    //category routes
    @Post('category/create')
    async createCategory(@Body() createCategoryDto: CreateCategoryDto, @Res() res) {
        return successResponse(res, 201, "Category created", await this.stockService.createCategory(createCategoryDto));
    }

    @Put('category/update/:id')
    async updateCategory(@Body() createCategoryDto: CreateCategoryDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Category updated", await this.stockService.updateCategory(id, createCategoryDto));
    }

    @Delete('category/delete/:id')
    async deleteCategory(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Category deleted", await this.stockService.deleteCategory(id));
    }

    //get all categories
    @Get('category/getAllCategories')
    async getAllCategories(@Res() res) {
        return successResponse(res, 201, "Categories", await this.stockService.findAllCategories());
    }

   //get one category
    @Post('category/getOneCategory/:id')
    async getOneCategory(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Category", await this.stockService.findOneCategory(id));
    }


    //product routes
    @Post('product/create')
    async createProduct(@Body() createProductDto: CreateProductDto, @Res() res) {
        return successResponse(res, 201, "Product created", await this.stockService.createProduct(createProductDto));
    }

    @Put('product/update/:id')
    async updateProduct(@Body() createProductDto: CreateProductDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Product updated", await this.stockService.updateProduct(id, createProductDto));
    }

    @Delete('product/delete/:id')
    async deleteProduct(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Product deleted", await this.stockService.deleteProduct(id));
    }
    //get all products
    @Get('product/getAllProducts')
    async getAllProducts(@Res() res) {
        return successResponse(res, 201, "Products", await this.stockService.findAllProducts());
    }

    //get pagenated products
    @Get('product/getPaginatedProducts/:page/:limit')
    async getPaginatedProducts(@Res() res, @Param('page') page: number, @Param('limit') limit: number) {
        return successResponse(res, 201, "Products", await this.stockService.getPaginatedProducts(page, limit));
    }

    //get product by id
    @Get('product/getProductById/:id')
    async getProductById(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Product", await this.stockService.findOneProduct(id));
    }

    //taxcode routes
    @Post('taxcode/create')
    async createTaxCode(@Body() createTaxCodeDto: CreateTaxCodeDto, @Res() res) {
        return successResponse(res, 201, "TaxCode created", await this.stockService.createTaxCode(createTaxCodeDto));
    }

    @Put('taxcode/update/:id')
    async updateTaxCode(@Body() createTaxCodeDto: CreateTaxCodeDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "TaxCode updated", await this.stockService.updateTaxCode(id, createTaxCodeDto));
    }

    @Delete('taxcode/delete/:id')
    async deleteTaxCode(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "TaxCode deleted", await this.stockService.deleteTaxCode(id));
    }

    //get all taxcodes
    @Get('taxcode/getAllTaxCodes')
    async getAllTaxCodes(@Res() res) {
        return successResponse(res, 201, "TaxCodes", await this.stockService.findAllTaxCodes());
    }

    //get one taxcode
    @Get('taxcode/getTaxCodeById/:id')
    async getTaxCodeById(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "TaxCode", await this.stockService.findOneTaxCode(id));
    }

    //unitmeasure routes
    @Post('unitmeasure/create')
    async createUnitMeasure(@Body() createUnitMeasureDto: CreateUnitMeasureDto, @Res() res) {
        return successResponse(res, 201, "UnitMeasure created", await this.stockService.createUnitMeasure(createUnitMeasureDto));
    }

    @Put('unitmeasure/update/:id')
    async updateUnitMeasure(@Body() createUnitMeasureDto: CreateUnitMeasureDto, @Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "UnitMeasure updated", await this.stockService.updateUnitMeasure(id, createUnitMeasureDto));
    }

    @Delete('unitmeasure/delete/:id')
    async deleteUnitMeasure(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "UnitMeasure deleted", await this.stockService.deleteUnitMeasure(id));
    }

    //get all unitmeasures
    @Get('unitmeasure/getAllUnitMeasures')
    async getAllUnitMeasures(@Res() res) {
        return successResponse(res, 201, "UnitMeasures", await this.stockService.findAllUnitMeasures());
    }

    //get one unitmeasure
    @Get('unitmeasure/getUnitMeasureById/:id')
    async getUnitMeasureById(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "UnitMeasure", await this.stockService.findOneUnitMeasure(id));
    }



}
