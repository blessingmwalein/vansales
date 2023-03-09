/*
https://docs.nestjs.com/providers#services
*/

import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateSheetDto } from 'src/dto/sheet';
import { SheetAllocationDto } from 'src/dto/sheet-allocation';
import SheetStatus from 'src/enums/sheet_status';
import { Sheet } from 'src/models/sheet';
import { SheetAllocation } from 'src/models/sheet-allocation';
import { WarehouseService } from 'src/warehouse/warehouse.service';

@Injectable()
export class SheetService {
    constructor(@InjectModel("Sheet") private readonly sheetModel: Model<Sheet>,
        @InjectModel("SheetAllocation") private readonly sheetAllocationModel: Model<SheetAllocation>,
        private wareHouseService: WarehouseService) { }

    async createSheet(sheet: CreateSheetDto): Promise<Sheet> {
        const createdSheet = new this.sheetModel(sheet);
        return createdSheet.save();
    }

    async findAllSheets(): Promise<Sheet[]> {
        return this.sheetModel.find()
            .populate('driver', ['first_name', 'last_name', 'phone_number', 'email', 'title', 'status'])
            .populate('route')
            .populate('truck')
            .populate('warehouse')
            .populate({
                path: 'allocated_stock',
                populate: {
                    path: 'product',
                }
            })
            .exec();
    }

    async findOneSheet(id: string): Promise<Sheet> {
        return this.sheetModel.findById(id)
            .populate('driver', ['first_name', 'last_name', 'phone_number', 'email', 'title', 'status'])
            .populate('route')
            .populate({
                path: 'allocated_stock',
                populate: {
                    path: 'product',
                }
            })
            .populate('truck').exec();
    }

    async updateSheet(id: string, sheet: CreateSheetDto): Promise<Sheet> {
        return this.sheetModel.findByIdAndUpdate(id, sheet, { new: true });
    }

    async deleteSheet(id: string): Promise<Sheet> {
        return this.sheetModel.findByIdAndRemove(id);
    }

    //create function to allocate products to sheet
    async allocateProductToSheet(sheetId: string, sheetAllocationDto: SheetAllocationDto[]): Promise<Sheet> {

        //create bulk insert
        //loop through the array of products
        sheetAllocationDto.forEach(async (sheetAllocation) => {
            //add the insert operation to the bulk
            if (await this.checkIfProductIsAllocatedToSheet(sheetId, sheetAllocation.product)) {
                await this.updateProductAllocation(sheetId, sheetAllocation.product, sheetAllocation);
            } else {
                console.log(sheetAllocation);
                const newAllocation = await new this.sheetAllocationModel({
                    sheet: sheetId,
                    product: sheetAllocation.product,
                    loaded_units: sheetAllocation.loaded_units,
                    returned_units: sheetAllocation.returned_units,
                    units_on_hand: sheetAllocation.units_on_hand,
                });
                newAllocation.save();
                //update sheet with allocated product
                await this.sheetModel.findByIdAndUpdate(sheetId, { $push: { allocated_stock: newAllocation._id } }).exec();
            }
        });
        this.updateSheetStatus(sheetId, SheetStatus.LOADED);
        return this.findOneSheet(sheetId);
    }

    //create function to remove product allocation
    async removeProductAllocation(sheetId: string, productId: string): Promise<Sheet> {
        //remove product allocation from sheet
        await this.sheetAllocationModel.findByIdAndRemove(productId).exec();
        //remove product allocation from sheet
        await this.sheetModel.findByIdAndUpdate(sheetId, { $pull: { allocated_stock: productId } }).exec();

        return this.findOneSheet(sheetId);
    }


    //create function to update sheet status
    async updateSheetStatus(sheetId: string, status: SheetStatus): Promise<Sheet> {
        return await this.sheetModel.findByIdAndUpdate(sheetId, { status: status }).exec();
    }

    //create function to close sheet
    async closeSheet(sheetId: string): Promise<Sheet> {
        const sheet = await this.findOneSheet(sheetId);
        await this.updateSheetStatus(sheetId, SheetStatus.CLOSED);
        //update warehouse stock
        sheet.allocated_stock.forEach(async (allocation) => {
            this.wareHouseService.updateStockQuantity(sheet.warehouse._id, allocation.loaded_units - allocation.units_on_hand, false);
        });
        return sheet;
    }
    //create function to check if product is already allocated to sheet
    async checkIfProductIsAllocatedToSheet(sheetId: string, productId: string): Promise<boolean> {
        const allocatedProduct = await this.sheetAllocationModel.findOne({ sheet: sheetId, product: productId }).exec();
        console.log(allocatedProduct);

        if (allocatedProduct) {
            return true;
        }
        return false;
    }

    //create function to update product allocation
    async updateProductAllocation(sheetId: string, productId: string, sheetAllocationDto: SheetAllocationDto): Promise<boolean> {
        await this.sheetAllocationModel.findOneAndUpdate(
            { sheet: sheetId, product: productId },
            { loaded_units: sheetAllocationDto.loaded_units, returned_units: sheetAllocationDto.returned_units, units_on_hand: sheetAllocationDto.units_on_hand },
        ).exec();
        return true;
    }

}
