<?php

namespace App\Http\Controllers;

use App\Http\Resources\ProductResource;
use App\Interfaces\ProductRepositoryInterface;
use App\Models\Product;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Interfaces\UtilityRepositoryInterface;
use App\Interfaces\ProductCategoryRepositoryInterface;
use Excel;
use App\Imports\ProductsImport;

class ProductController extends Controller
{
    private ProductRepositoryInterface $productRepository;
    private UtilityRepositoryInterface $utilityRepository;
    private ProductCategoryRepositoryInterface $productCategoryRepository;


    public function __construct(ProductRepositoryInterface $productRepository, UtilityRepositoryInterface $utilityRepository, ProductCategoryRepositoryInterface $productCategoryRepository)
    {
        $this->productRepository = $productRepository;
        $this->utilityRepository = $utilityRepository;
        $this->productCategoryRepository = $productCategoryRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Stock/Products', [
            'products' => ProductResource::collection($this->productRepository->getPaginated(10)),
            'categories' => $this->productCategoryRepository->all(),
            'unitMeasures' => $this->utilityRepository->getAllUnitMeasures(),
            'taxs' => $this->utilityRepository->getAllTaxs(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'product_category_id' => 'required',
            'description' => 'required',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'reorder_level' => 'required',
            'unit_measure_id' => 'required',
            'tax_id' => 'required',
            'discount' => 'nullable',
            'retail_unit_price' => 'nullable',
            'wholesale_unit_price' => 'nullable',
        ]);

        $this->productRepository->create($data);
        return back()->with('success', 'Product created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Product $product)
    {
        return Inertia::render('Stock/ProductShow', [
            'product' => new ProductResource($product),
            'categories' => $this->productCategoryRepository->all(),
            'unitMeasures' => $this->utilityRepository->getAllUnitMeasures(),
            'taxs' => $this->utilityRepository->getAllTaxs(),
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Product $product)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Product $product)
    {
        $data = $request->validate([
            'product_category_id' => 'required',
            'description' => 'required',
            'reorder_level' => 'required',
            'unit_measure_id' => 'required',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'tax_id' => 'required',
            'discount' => 'nullable',
            'retail_unit_price' => 'nullable',
            'wholesale_unit_price' => 'nullable',
        ]);



        $this->productRepository->update($data, $product->id);
        return back()->with('success', 'Product updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {
        $this->productRepository->delete($product->id);
        return back()->with('success', 'Product deleted successfully.');
    }

    //search product by code or description
    public function searchByCodeName(Request $request)
    {
        $code = $request->code;
        $description = $request->description;
        $categories = $request->categories;
        $taxs = $request->taxs;
        $unitMeasures = $request->unitMeasures;
        $from =$request->from;
        $to =$request->to;

        $products = $this->productRepository->filter($code, $description, $categories, $taxs, $unitMeasures, $from, $to);
        return ProductResource::collection($products);
    }

    public function uploadExcelProducts(Request $request)
    {
        $collection = Excel::toArray(new ProductsImport, $request->file('products_template'));
        return $collection;
    }
    public function saveExcelProducts(Request $request)
    {
        $save = Excel::import(new ProductsImport, $request->file('products_template'));
        return back()->with('success', 'Products imported successfully.');
    }
}
