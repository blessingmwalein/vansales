import { InvoiceModule } from './invoice/invoice.module';
import { SheetModule } from './sheet/sheet.module';
import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose/dist/mongoose.module';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { WarehouseModule } from './warehouse/warehouse.module';
import { StockModule } from './stock/stock.module';
import { StockAllocationModule } from './stock-allocation/stock-allocation.module';
import { RouteModule } from './route/route.module';
import { TruckModule } from './truck/truck.module';


@Module({
  imports: [
        InvoiceModule, 
    SheetModule,
    MongooseModule.forRoot(
      'mongodb+srv://code-academy:password23@cluster0.tbocvfg.mongodb.net/van-sales?retryWrites=true&w=majority',
    ),
    AuthModule,
    UsersModule,
    WarehouseModule,
    StockModule,
    StockAllocationModule,
    RouteModule,
    TruckModule
  ],
  controllers: [],
  providers: [AppService],
})
export class AppModule { }
