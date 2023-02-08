import { ApiProperty } from "@nestjs/swagger";


export class CreateWarehouseDto {
    @ApiProperty()
    name: string;
    @ApiProperty()
    code: string;
    @ApiProperty()
    lat: string;
    @ApiProperty()
    lon: string;
    @ApiProperty()
    allocated_stock: number;
}
