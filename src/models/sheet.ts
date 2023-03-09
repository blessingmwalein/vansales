import SheetStatus from "src/enums/sheet_status";
import { User } from "./user";
import { Route } from "./route";
import { Truck } from "./truck";
import { SheetAllocation } from "./sheet-allocation";
import { Warehouse } from "./warehouse";
import { Invoice } from "./invoice";

export class Sheet {
    _id: string;
    number: string;
    driver: User;
    warehouse: Warehouse;
    status: SheetStatus;
    route: Route;
    truck: Truck;
    allocated_stock: SheetAllocation[];
    start_date_time: Date;
    invoices: Invoice[];
    updated_at: Date;
    created_at: Date;
}

