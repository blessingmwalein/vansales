import { StockService } from './../stock/stock.service';
import { CreateStockAllocationDto, TransferStockDto } from './../dto/stock-allocation';
import { StockAllocation } from './../models/stock-allocation';
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Category } from 'src/models/product';
import { WarehouseService } from 'src/warehouse/warehouse.service';

@Injectable()
export class StockAllocationService {
    constructor(@InjectModel("StockAllocation") private readonly stockAllocationModel: Model<StockAllocation>, private stockService: StockService, private warehouseService: WarehouseService) {

    }

    async create(stockAllocation: CreateStockAllocationDto): Promise<StockAllocation> {
        const createdStockAllocation = new this.stockAllocationModel(stockAllocation);

        //subtract allocated quantity from stock
        const stock = await this.stockService.updateStockQuantity(stockAllocation.product, stockAllocation.units_allocated, false);

        //update warehouse stock
        const warehouseStock = await this.warehouseService.updateStockQuantity(stockAllocation.warehouse, stockAllocation.units_allocated, true);

        return createdStockAllocation.save();
    }

    async findAll(): Promise<StockAllocation[]> {
        return this.stockAllocationModel.find()
            .populate('product')
            .populate('warehouse')
            .populate('allocatedBy')
            .exec();
    }

    async findOne(id: string): Promise<StockAllocation> {
        return this.stockAllocationModel.findById(id)
            .populate('product')
            .populate('warehouse')
            .populate('allocatedBy')
            .exec();

    }

    async update(id: string, stockAllocation: CreateStockAllocationDto): Promise<StockAllocation> {

        return this.stockAllocationModel.findByIdAndUpdate(id, stockAllocation, { new: true });
    }

    async remove(id: string): Promise<StockAllocation> {
        return this.stockAllocationModel.findByIdAndRemove(id);
    }

    //find by warehouse
    async findByWarehouse(warehouse: string): Promise<StockAllocation[]> {
        return this.stockAllocationModel.find({ warehouse: warehouse })
            .populate('product')
            .populate('warehouse')
            .populate('allocatedBy')
            .exec();

    }

    //find by product
    async findByProduct(product: string): Promise<StockAllocation[]> {
        return this.stockAllocationModel.find({ product: product })
            .populate('product')
            .populate('warehouse')
            .populate('allocatedBy')
            .exec();
    }

    //find by allocatedBy
    async findByAllocatedBy(allocatedBy: string): Promise<StockAllocation[]> {
        return this.stockAllocationModel.find({ allocatedBy: allocatedBy })
            .populate('product')
            .populate('warehouse')
            .populate('allocatedBy')
            .exec();
    }

    //transfer stock from one warehouse to another
    async transferStock(transferStockDto:TransferStockDto): Promise<StockAllocation | boolean> {
        const stockFound = await this.findOne(transferStockDto.allocationId);
        if (stockFound) {
            if (stockFound.units_allocated >= transferStockDto.units) {
                //update stock
                const updatedStock = await this.stockService.updateStockQuantity(stockFound._id, transferStockDto.units, false);
                //update warehouseFrom stock
                const transferWarehouseStock =await this.warehouseService.transferStock(transferStockDto.warehouseFrom, transferStockDto.warehouseTo, transferStockDto.units);
                const createdStockAllocation = new this.stockAllocationModel({
                    product: stockFound.product,
                    units_allocated: transferStockDto.units,
                    warehouse: transferStockDto.warehouseTo,
                    allocatedBy: stockFound.allocatedBy
                });
                return createdStockAllocation;
            }
            return false;
        }
        return false;
    }

    //create bulk stock transfer from one warehouse to another
    async bulkTransferStock(transferStockDto:TransferStockDto[]): Promise<StockAllocation | boolean> {
        transferStockDto.forEach(async (transferStock) => {
            this.transferStock(transferStock);
        });
        return true;
    }
       
    async updateStockQuantity(id: string, quantity: number, increase: boolean): Promise<boolean> {
        const stockAllocation: StockAllocation = await this.findOne(id);

        if ((stockAllocation.units_allocated < quantity) && (!increase)) {
            return false;
        }
        !increase ? stockAllocation.units_allocated -= quantity : stockAllocation.units_allocated += quantity;
        await this.stockAllocationModel.findByIdAndUpdate(id, stockAllocation, { new: true });
        return true;
    }

}
