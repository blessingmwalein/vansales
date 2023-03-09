import { ApiProperty } from "@nestjs/swagger";
import { Point } from "src/models/route";

export class InvoiceDto {
    @ApiProperty()
    number: string;
    @ApiProperty()
    driver: string;
    @ApiProperty()
    customer: string;
    @ApiProperty()
    status: string;
    @ApiProperty()
    sheet: string;
    @ApiProperty()
    items: InvoiceItemDto[];
    @ApiProperty()
    location: Point;
    @ApiProperty()
    total: number;
    @ApiProperty()
    customer_signature: number;
    @ApiProperty()
    driver_signature: number;
}

export class InvoiceItemDto {
    @ApiProperty()
    sold_units: number;
    @ApiProperty()
    product: string;
}
export class SignatureDto {
    @ApiProperty({
        type: 'array',
        items: {
          type: 'string',
          format: 'binary',
        },
        required: false,
      })
      signatures: Express.Multer.File;
}

export const SignatureApiSchema = () => {
    return {
      schema: {
        type: 'object',
        properties: [{
          signature_url: {
            type: 'string',
            format: 'binary',
          },
        }],
      },
    };
  };
