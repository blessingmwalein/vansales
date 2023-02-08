import { ApiProperty } from "@nestjs/swagger";


export class CreateCategoryDto {
    @ApiProperty()
    name: string;
}
export class CreateProductDto {
    @ApiProperty()
    name: string;
    @ApiProperty()
    code: string;
    @ApiProperty()
    retail_price: number;
    @ApiProperty()
    wholesale_price: number;
    @ApiProperty()
    category: string;
    @ApiProperty()
    tax_code: string;
    @ApiProperty()
    unit_measure: string;
    @ApiProperty()
    isReturnable: boolean;
    @ApiProperty()
    units_on_hand: number;

}

export class CreateTaxCodeDto {
    @ApiProperty()
    name: string;
    @ApiProperty()
    rate: number;
}

export class CreateUnitMeasureDto {
    @ApiProperty()
    name: string;
}
