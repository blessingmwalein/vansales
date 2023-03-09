import { CreateCategoryDto, CreateTaxCodeDto, CreateUnitMeasureDto, CreateProductDto } from './../dto/product';
import { Category, Product, UnitMeasure, TaxCode } from './../models/product';
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

@Injectable()
export class StockService {

    constructor(
        @InjectModel("Category") private readonly categoryModel: Model<Category>,
        @InjectModel("Product") private readonly productModel: Model<Product>,
        @InjectModel("UnitMeasure") private readonly unitMeasureModel: Model<UnitMeasure>,
        @InjectModel("TaxCode") private readonly taxCodeModel: Model<TaxCode>,
    ) {

    }

    //categories 
    async createCategory(category: CreateCategoryDto): Promise<Category> {
        const createdCategory = new this.categoryModel(category);
        return createdCategory.save();
    }

    async findAllCategories(): Promise<Category[]> {
        return this.categoryModel.find().exec();
    }

    async findOneCategory(id: string): Promise<Category> {
        return this.categoryModel.findById(id).exec();
    }

    async updateCategory(id: string, category: CreateCategoryDto): Promise<Category> {
        return this.categoryModel.findByIdAndUpdate(id, category, { new: true });
    }

    async deleteCategory(id: string): Promise<Category> {
        return this.categoryModel.findByIdAndRemove(id);
    }

    //products
    async createProduct(product: CreateProductDto): Promise<Product> {
        const createdProduct = new this.productModel(product);
        return createdProduct.save();
    }

    //get pagenated products
    async getPaginatedProducts(page: number, limit: number): Promise<any> {

        page = Math.max(0, page);
        const products: Product[] = await this.productModel
            .find()
            .limit(limit)
            .skip(limit * page)
            .sort('asc')
            .populate('category')
            .populate('tax_code')
            .populate('unit_measure')
            .exec();

        return {
            products,
            pages: Math.ceil(await this.productModel.countDocuments().exec() / limit),
            page: page
        };
    }

    async findAllProducts(): Promise<Product[]> {
        return this.productModel
            .find()
            .populate('category')
            .populate('tax_code')
            .populate('unit_measure')
            .exec();
    }

    async findOneProduct(id: string): Promise<Product> {
        return this.productModel.findById(id).exec();
    }

    async updateProduct(id: string, product: CreateProductDto): Promise<Product> {
        return this.productModel
            .findByIdAndUpdate(id, product, { new: true });
    }

    async deleteProduct(id: string): Promise<Product> {
        return this.productModel.findByIdAndRemove(id);
    }

    //unit measures
    async createUnitMeasure(unitMeasure: CreateUnitMeasureDto): Promise<UnitMeasure> {
        const createdUnitMeasure = new this.unitMeasureModel(unitMeasure);
        return createdUnitMeasure.save();
    }

    async findAllUnitMeasures(): Promise<UnitMeasure[]> {
        return this.unitMeasureModel.find().exec();
    }

    async findOneUnitMeasure(id: string): Promise<UnitMeasure> {
        return this.unitMeasureModel.findById(id).exec();
    }

    async updateUnitMeasure(id: string, unitMeasure: CreateUnitMeasureDto): Promise<UnitMeasure> {
        return this.unitMeasureModel.findByIdAndUpdate(id, unitMeasure, { new: true });
    }

    async deleteUnitMeasure(id: string): Promise<UnitMeasure> {
        return this.unitMeasureModel.findByIdAndRemove(id);
    }

    //tax codes

    async createTaxCode(taxCode: CreateTaxCodeDto): Promise<TaxCode> {
        const createdTaxCode = new this.taxCodeModel(taxCode);
        return createdTaxCode.save();
    }

    async findAllTaxCodes(): Promise<TaxCode[]> {
        return this.taxCodeModel.find().exec();
    }

    async findOneTaxCode(id: string): Promise<TaxCode> {
        return this.taxCodeModel.findById(id).exec();
    }

    async updateTaxCode(id: string, taxCode: CreateTaxCodeDto): Promise<TaxCode> {
        return this.taxCodeModel.findByIdAndUpdate(id, taxCode, { new: true });
    }

    async deleteTaxCode(id: string): Promise<TaxCode> {
        return this.taxCodeModel.findByIdAndRemove(id);
    }

    //helper methods
    //create method to reduce stock quantity
    async updateStockQuantity(id: string, quantity: number, increase: boolean): Promise<boolean> {
        const product: Product = await this.findOneProduct(id);
        console.log('this'+ product.units_on_hand);
        if ((product.units_on_hand < quantity) && (!increase)) {
            return false;
        }
        !increase ? product.units_on_hand -= quantity : product.units_on_hand += quantity;
        await this.productModel.findByIdAndUpdate(id, product, { new: true });
        return true;
    }

}
