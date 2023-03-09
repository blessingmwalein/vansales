import { ApiProperty } from "@nestjs/swagger";
import SheetStatus from "src/enums/sheet_status";

export class SheetAllocationDto {
    @ApiProperty()
    loaded_units: number;
    @ApiProperty()
    returned_units: number;
    @ApiProperty()
    units_on_hand: number;
    @ApiProperty()
    product: string;
    @ApiProperty()
    sheet: string;
}
export class UpdateSheetStatusDto {
    @ApiProperty()
    status: SheetStatus;
}
