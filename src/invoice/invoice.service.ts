/*
https://docs.nestjs.com/providers#services
*/

import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { InvoiceDto } from 'src/dto/invoice';
import { Invoice } from 'src/models/invoice';

@Injectable()
export class InvoiceService {

    constructor(
        @InjectModel('Invoice') private readonly invoiceModel: Model<Invoice>,
        @InjectModel('Sheet') private readonly sheetModel: Model<Invoice>,
    ) {
    }

    //create function to sync bulk invoices
    async syncBulkInvoices(sheetId: string, invoices: InvoiceDto[]): Promise<Invoice[]> {
        const result = await this.invoiceModel.insertMany(invoices);
        this.sheetModel.findByIdAndUpdate(sheetId, { $push: { invoices: result } }).exec();
        return result;
    }

    //create function to sync single invoice
    async syncSingleInvoice(sheetId,invoice: InvoiceDto): Promise<Invoice> {
        const result = await this.invoiceModel.create(invoice);
        this.sheetModel.findByIdAndUpdate(sheetId, { $push: { invoices: result } }).exec();
        return result;
    }

    //create function to get all invoices
    async getAllInvoices(): Promise<Invoice[]> {
        const result = await this.invoiceModel.find()
            .populate('driver')
            .populate('customer')
            .populate('sheet')
            .populate({
                path: 'items',
                populate: {
                    path: 'product',
                }
            }).exec();
        return result;
    }

    //create function to get single invoice
    async getSingleInvoice(id: string): Promise<Invoice> {
        return await this.invoiceModel.findById(id)
            .populate('driver')
            .populate('customer')
            .populate('sheet')
            .populate({
                path: 'items',
                populate: {
                    path: 'product',
                }
            }).exec();

    }

    //create function to upload customer signatures
    async uploadBulkSignatures(files:any){

    }
}
