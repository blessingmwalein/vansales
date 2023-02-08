import { ApiProperty } from "@nestjs/swagger";

export class CreateTruckDto {  
    @ApiProperty()
    make: string;
    @ApiProperty()
    reg_number: string;
    @ApiProperty()
    default_driver: string;
    @ApiProperty()
    mileage: number;
}