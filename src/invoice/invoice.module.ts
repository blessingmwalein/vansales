import { InvoiceItemSchema, InvoiceSchema } from 'src/schemas/invoice';
import { InvoiceController } from './invoice.controller';
import { InvoiceService } from './invoice.service';
/*
https://docs.nestjs.com/modules
*/

import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { PointSchema } from 'src/schemas/route';
import { SheetSchema } from 'src/schemas/sheet';

@Module({
    imports: [
        MongooseModule.forFeature([
            { name: 'Invoice', schema: InvoiceSchema },
            { name: 'InvoiceItem', schema: InvoiceItemSchema },
            { name: 'Point', schema: PointSchema },
            { name: 'Sheet', schema: SheetSchema },

        ])
    ],
    controllers: [
        InvoiceController,],
    providers: [
        InvoiceService,],
})
export class InvoiceModule { }
