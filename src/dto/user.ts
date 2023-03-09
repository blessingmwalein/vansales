import { ApiProperty } from "@nestjs/swagger";
import Role from "src/enums/role";
import { Point } from "src/models/route";

export class CreateUserDto {
    _id: string;
    @ApiProperty()
    first_name: string;
    @ApiProperty()
    last_name: string;
    @ApiProperty()
    title: string;
    @ApiProperty()
    email: string;
    @ApiProperty()
    phone_number: string
    @ApiProperty()
    password: string;
    @ApiProperty({ enum: Object.values(Role) })
    role: Role
}
export class CustomerDetailsDto {
    _id: string;
    @ApiProperty()
    company: string;
    @ApiProperty()
    address: string;
    @ApiProperty()
    location: Point
}
