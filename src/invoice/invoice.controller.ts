/*
https://docs.nestjs.com/controllers#controllers
*/

import { Body, Controller, Get, Param, Post, Res, UploadedFiles, UseGuards, UseInterceptors } from '@nestjs/common';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { RolesGuard } from 'src/auth/guards/role';
import { JwtAuthGuard } from 'src/auth/jwt/jwt-auth.guard';
import { Roles } from 'src/decorators/role';
import Role from 'src/enums/role';
import { InvoiceService } from './invoice.service';
import { InvoiceDto, SignatureApiSchema, SignatureDto } from 'src/dto/invoice';
import { successResponse } from 'src/response/success';
import { FilesInterceptor } from '@nestjs/platform-express';


@ApiBearerAuth()
@ApiTags('Invoice')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(Role.Admin, Role.Salesman)
@Controller('invoice')
export class InvoiceController {
    constructor(private invoiceService: InvoiceService) { }

    //bulk upload invoices
    @Post('syncBulkSignatures/:sheetId')
    async createRoute(@Body() inovoiceDto: InvoiceDto[], @Res() res, @Param('sheetId') sheetId: string) {
        return successResponse(res, 201, "Invoice Synced", await this.invoiceService.syncBulkInvoices(sheetId, inovoiceDto));
    }
    @Post('syncSingleSignatures/:sheetId')
    async syncSingleSignatures(@Body() inovoiceDto: InvoiceDto, @Res() res, @Param('sheetId') sheetId: string) {
        return successResponse(res, 201, "Invoice Synced", await this.invoiceService.syncSingleInvoice(sheetId, inovoiceDto));
    }
    @Get('getAllInvoices')
    async getAllInvoices(@Res() res) {
        return successResponse(res, 201, "Invoices", await this.invoiceService.getAllInvoices());
    }

    @Get('getOneInvoice/:id')
    async getOneInvoice(@Res() res, @Param('id') id: string) {
        return successResponse(res, 201, "Invoice", await this.invoiceService.getSingleInvoice(id));
    }


    //upload signatures
    @Post('uploadSignatures')
    @UseInterceptors(FilesInterceptor('files'))
    @ApiConsumes('multipart/form-data')
    async uploadSignatures(@Res() res, @Body() data: SignatureDto) {
        return successResponse(res, 201, "Files Uploaded", data);
    }

}
