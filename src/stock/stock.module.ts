import { CategorySchema, ProductSchema, TaxCodeSchema, UnitMeasureSchema } from './../schemas/product';
import { Global, Module } from '@nestjs/common';
import { StockService } from './stock.service';
import { StockController } from './stock.controller';
import { MongooseModule } from '@nestjs/mongoose';


@Global()
@Module({
  providers: [StockService],
  controllers: [StockController],
  imports: [
    MongooseModule.forFeature([
      { name: 'Category', schema: CategorySchema },
      { name: 'Product', schema: ProductSchema },
      { name: 'TaxCode', schema: TaxCodeSchema },
      { name: 'UnitMeasure', schema: UnitMeasureSchema },
    ])
  ],
  exports: [StockService]
})
export class StockModule {}
