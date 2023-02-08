import { Route } from './../models/route';
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateRouteDto } from 'src/dto/route';

@Injectable()
export class RouteService {
    constructor(@InjectModel("Route") private readonly routeModel: Model<Route>) { }

    async create(routeDto: CreateRouteDto): Promise<Route> {
        const createdRoute = new this.routeModel(routeDto);

        return createdRoute.save();
    }


    async findAll(): Promise<Route[]> {
        return this.routeModel.find().exec();
    }

    async findOne(id: string): Promise<Route> {
        return this.routeModel.findById(id).exec();
    }

    async update(id: string, routeDto: CreateRouteDto): Promise<Route> {
        
        return this.routeModel.findByIdAndUpdate(id, routeDto, { new: true });
    }

    async remove(id: string): Promise<Route> {
        return this.routeModel.findByIdAndRemove(id);
    }

    async findByCode(code: string): Promise<Route> {
        return this.routeModel.findOne({ code: code }).exec();
    }
    
    
}
