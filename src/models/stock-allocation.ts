import { Product } from './product';
import { User } from './user';
import { Warehouse } from './warehouse';

export class StockAllocation {
    _id: string;
    units_allocated: number;
    product: Product;
    warehouse: Warehouse;
    allocatedBy: User;
    updated_at: Date;
    created_at: Date;
}