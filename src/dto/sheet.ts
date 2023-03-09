import { ApiProperty } from "@nestjs/swagger";

export class CreateSheetDto {
    @ApiProperty()
    number: string;
    @ApiProperty()
    driver: string;
    @ApiProperty()
    warehouse: string;
    @ApiProperty()
    route: string;
    @ApiProperty()
    truck:string;
    @ApiProperty()
    start_date_time: Date;
}
