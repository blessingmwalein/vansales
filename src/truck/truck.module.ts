import { Module } from '@nestjs/common';
import { TruckService } from './truck.service';
import { TruckController } from './truck.controller';
import { TruckSchema } from 'src/schemas/truck';
import { MongooseModule } from '@nestjs/mongoose/dist/mongoose.module';

@Module({
  providers: [TruckService],
  controllers: [TruckController],
  imports: [
    MongooseModule.forFeature([
      { name: 'Truck', schema: TruckSchema },
    ])
  ]
})
export class TruckModule {}
