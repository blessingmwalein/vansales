import { UsersModule } from 'src/users/users.module';
import { Module, Global } from '@nestjs/common';
import { WarehouseService } from './warehouse.service';
import { WarehouseController } from './warehouse.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { WarehouseSchema } from 'src/schemas/warehouse';

@Global()
@Module({
  providers: [WarehouseService],
  controllers: [WarehouseController],
  imports: [MongooseModule.forFeature([{ name: 'Warehouse', schema: WarehouseSchema }])],
  exports: [WarehouseService]
})
export class WarehouseModule {}
