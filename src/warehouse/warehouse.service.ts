import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateWarehouseDto } from 'src/dto/warehouse';
import { Warehouse } from 'src/models/warehouse';

@Injectable()
export class WarehouseService {
    constructor(@InjectModel("Warehouse") private readonly warehouseModel: Model<Warehouse>) {
        
    }

    async create(warehouse: CreateWarehouseDto): Promise<Warehouse> {
        const createdWarehouse = new this.warehouseModel(warehouse);
        return createdWarehouse.save();
    }

    async findAll(): Promise<Warehouse[]> {
        return this.warehouseModel.find().exec();
    }

    async findOne(id: string): Promise<Warehouse> {
        return this.warehouseModel.findById(id).exec();
    }

    async update(id: string, warehouse: CreateWarehouseDto): Promise<Warehouse> {
        return this.warehouseModel.findByIdAndUpdate(id, warehouse, { new: true });
    }

    async delete(id: string): Promise<Warehouse> {
        return this.warehouseModel.findByIdAndRemove(id);
    }

    //get pagenated warehouses
    async getPaginatedWarehouses(page: number, limit: number): Promise<Warehouse[]> {
        const startIndex = (page - 1) * limit;
        const endIndex = page * limit;
        const results = {};

        if (endIndex < await this.warehouseModel.countDocuments().exec()) {
            results['next'] = {
                page: page + 1,
                limit: limit
            }
        }

        if (startIndex > 0) {
            results['previous'] = {
                page: page - 1,
                limit: limit
            }
        }
        try {
            results['results'] = await this.warehouseModel.find().limit(limit).skip(startIndex).exec();
            return results['results'];
        } catch (e) {
            return e;
        }
    }

    //helper function to get warehouse stock
    async updateStockQuantity(id: string, quantity: number, increase:boolean): Promise<boolean>{
        const warehouse: Warehouse = await this.findOne(id);
        if((warehouse.allocated_stock < quantity) && (!increase)){
            return false;
        }
        increase ? warehouse.allocated_stock += quantity : warehouse.allocated_stock -= quantity;
        await this.warehouseModel.findByIdAndUpdate(id, warehouse, { new: true });
        return true;
    }

    //create fuction to transfer stock from one warehouse to another
    async transferStock(fromWarehouseId: string, toWarehouseId: string, quantity: number): Promise<boolean>{
        this.updateStockQuantity(fromWarehouseId, quantity, false);
        this.updateStockQuantity(toWarehouseId, quantity, true);
        return true;
    }

    

}
