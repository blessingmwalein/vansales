import { Type } from 'class-transformer';
import { ApiProperty } from "@nestjs/swagger";
import { Point } from "src/models/route";

export class CreateRouteDto {
    @ApiProperty()
    name: string;
    @ApiProperty()
    code: string;
    @Type(() => Point)
    origin: Point;
    @Type(() => Point)
    destination: Point;
    @Type(() => Point)
    waypoints: Point[];
    @ApiProperty()
    average_distance: number;
    @ApiProperty()
    average_duration: number;
}
