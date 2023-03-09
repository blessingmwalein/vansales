import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateTruckDto } from 'src/dto/truck';
import { Truck } from 'src/models/truck';

@Injectable()
export class TruckService {
    constructor(@InjectModel("Truck") private readonly truckModel: Model<Truck>) { }

    async create(truckDto: CreateTruckDto): Promise<Truck> {
        const createdTruck = new this.truckModel(truckDto);

        return createdTruck.save();
    }
    async findAll(): Promise<Truck[]> {
        return this.truckModel.find().exec();
    }

    async findOne(id: string): Promise<Truck> {
        return this.truckModel.findById(id).exec();
    }

    async update(id: string, truckDto: CreateTruckDto): Promise<Truck> {
        
        return this.truckModel.findByIdAndUpdate(id, truckDto, { new: true });
    }

    async remove(id: string): Promise<Truck> {
        return this.truckModel.findByIdAndRemove(id);
    }


}
