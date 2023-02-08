
export class Category {
    _id: string;
    name: string;
    updated_at: Date;
    created_at: Date;
}

export class Product {
    _id: string;
    code: string;
    name: string;
    units_on_hand: number;
    category: Category;
    tax_code: TaxCode;
    retail_price: number;
    wholesale_price: number;
    unit_measure: UnitMeasure;
    isReturnable:boolean;
    updated_at: Date;
    created_at: Date;
}

export class TaxCode {
    _id: string;
    name: string;
    rate: number;
    updated_at: Date;
    created_at: Date;
}

export class UnitMeasure {
    _id: string;
    name: string;
    updated_at: Date;
    created_at: Date;
}