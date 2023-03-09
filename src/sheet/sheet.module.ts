import { SheetService } from './sheet.service';
import { SheetController } from './sheet.controller';
/*
https://docs.nestjs.com/modules
*/

import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { SheetSchema } from 'src/schemas/sheet';
import { SheetAllocationSchema } from 'src/schemas/sheet_allocation';
import { ProductSchema } from 'src/schemas/product';
import { UserSchema } from 'src/schemas/user';
import { RouteSchema } from 'src/schemas/route';
import { TruckSchema } from 'src/schemas/truck';
import { WarehouseSchema } from 'src/schemas/warehouse';
import { InvoiceSchema } from 'src/schemas/invoice';

@Module({
    imports: [
        MongooseModule.forFeature([
            { name: 'Sheet', schema: SheetSchema },
            { name: 'SheetAllocation', schema: SheetAllocationSchema },
            { name: 'User', schema: UserSchema },
            { name: 'Route', schema: RouteSchema },
            { name: 'Product', schema: ProductSchema },
            { name: 'Truck', schema: TruckSchema },
            { name: 'Warehouse', schema: WarehouseSchema },
            { name: 'Invoice', schema: InvoiceSchema },
        ])
    ],
    controllers: [
        SheetController,],
    providers: [
        SheetService],
    exports: [
        SheetService
    ]
})
export class SheetModule { }
