<?php

namespace App\Http\Controllers;

use App\Interfaces\ProductCategoryRepositoryInterface;
use App\Models\ProductCategory;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ProductCategoryController extends Controller
{

    private ProductCategoryRepositoryInterface $productCategoryRepository;

    public function __construct(ProductCategoryRepositoryInterface $productCategoryRepository)
    {
        $this->productCategoryRepository = $productCategoryRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Stock/ProductCategory', [
            'productCategories' => $this->productCategoryRepository->getPaginated(5),
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
            'name' => 'required|unique:product_categories,name',
            'description' => 'nullable',
        ]);

        $this->productCategoryRepository->create($data);
        return redirect()->back()->with('success', 'Product category created.');
    }

    /**
     * Display the specified resource.
     */
    public function show(ProductCategory $productCategory)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(ProductCategory $productCategory)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, ProductCategory $productCategory)
    {

        $data = $request->only(['name', 'description']);

        $this->productCategoryRepository->update($data, $productCategory->id);
        return redirect()->back()->with('success', 'Product category updated.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ProductCategory $productCategory)
    {
        $this->productCategoryRepository->delete($productCategory->id);
        return redirect()->back()->with('success', 'Product category deleted.');
    }
}
