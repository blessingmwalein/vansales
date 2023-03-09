import { Product } from "./product";
import { Sheet } from "./sheet";

export class SheetAllocation {
    _id: string;
    loaded_units: number;
    returned_units: number;
    units_on_hand: number;
    product: Product;
    sheet:Sheet;
    updated_at: Date;
    created_at: Date;
}

