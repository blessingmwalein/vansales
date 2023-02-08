import { RouteSchema } from './../schemas/route';
import { Module } from '@nestjs/common';
import { RouteService } from './route.service';
import { RouteController } from './route.controller';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  providers: [RouteService],
  controllers: [RouteController],
  imports: [
    MongooseModule.forFeature([
      { name: 'Route', schema: RouteSchema },
    ])
  ],
})
export class RouteModule {}
