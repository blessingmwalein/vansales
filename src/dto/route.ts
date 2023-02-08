import { ApiProperty } from "@nestjs/swagger";
import { Point } from "src/models/route";

export class CreateRouteDto {
    @ApiProperty()
    name: string;
    @ApiProperty()
    code: string;
    @ApiProperty()
    origin: Point;
    @ApiProperty()
    destination: Point;
    @ApiProperty()
    waypoints: Point[];
    @ApiProperty()
    average_distance: number;
    @ApiProperty()
    average_duration: number;
}
