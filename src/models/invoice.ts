import InvoiceStatus from "src/enums/invoice_status";
import { Product } from "./product";
import { User } from "./user";
import { Sheet } from "./sheet";
import { Point } from "./route";

export class Invoice {
    _id: string;
    driver: User;
    customer: User;
    status: InvoiceStatus;
    sheet: Sheet;
    items: InvoiceItem[];
    location: Point;
    total: number;
    customer_signature:string;
    driver_signature:string;
    updated_at: Date;
    created_at: Date;
}

export class InvoiceItem {
    product: Product;
    sold_units: number;
}