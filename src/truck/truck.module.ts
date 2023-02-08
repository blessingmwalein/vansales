import { Module } from '@nestjs/common';
import { TruckService } from './truck.service';
import { TruckController } from './truck.controller';

@Module({
  providers: [TruckService],
  controllers: [TruckController]
})
export class TruckModule {}
