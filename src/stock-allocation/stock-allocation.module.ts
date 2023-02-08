import { StockAllocationSchema } from './../schemas/stock-allocation';
import { Module } from '@nestjs/common';
import { StockAllocationService } from './stock-allocation.service';
import { StockAllocationController } from './stock-allocation.controller';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  providers: [StockAllocationService],
  controllers: [StockAllocationController],
  imports: [
    MongooseModule.forFeature([
      { name: 'StockAllocation', schema: StockAllocationSchema },
    ])
  ],
})
export class StockAllocationModule {}
