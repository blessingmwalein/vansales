import { ApiProperty } from "@nestjs/swagger";

export class CreateStockAllocationDto {
    @ApiProperty()
    units_allocated: number;
    @ApiProperty()
    product: string;
    @ApiProperty()
    warehouse: string;
    @ApiProperty()
    allocatedBy: string;
}

export class TransferStockDto {
    @ApiProperty()
    warehouseFrom: string;
    @ApiProperty()
    warehouseTo: string;
    @ApiProperty()
    allocationId: string;
    @ApiProperty()
    units: number;
}