<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddProductModal from '@/Components/Warehouse/AddProductModal.vue';
import UploadExcelProductsModal from '@/Components/Warehouse/UploadExcelProductsModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddProductModal,
        MainLayout,
        CopyButton,
        UploadExcelProductsModal,
        TableLayout
    },
    mixins: [globalMixin],

    props: ['products', 'categories', 'unitMeasures', 'taxs'],
    data() {
        return {
            selectedProduct: null,
            addProductModal: null,
            uploadExcelProductModal: null,
            deleteModal: null,
            products_data: this.products,
            search: '',
            isLoading: false,
        }
    },
    mounted() {
        const $targetEl = document.getElementById('add-product-modal');
        this.addProductModal = new Modal($targetEl);

        const $targetElUpload = document.getElementById('upload-excel-product');
        this.uploadExcelProductModal = new Modal($targetElUpload);

        const $deleteModalEl = document.getElementById('delete-product-modal');
        this.deleteModal = new Modal($deleteModalEl);

    },


    methods: {
        openAddProductModal() {
            this.selectedProduct = null;
            this.addProductModal.show();
        },
        openUploadModal() {
            this.uploadExcelProductModal.show();
        },

        closeAddProductModal() {
            this.addProductModal.hide();
        },
        closeUploadExcelModal() {
            this.uploadExcelProductModal.hide();
        },
        closeUploadModal() {
            this.uploadExcelProductModal.hide();
        },
        downloadExcel() {
            window.location.href = '/assets/templates/products_template.xlsx';
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },

        deleteProduct() {
            this.$inertia.delete(`/admin/products/${this.selectedProduct.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.closeDeleteModal();
                }
            });
        },
        formartDate(value) {
            if (value) {
                let date = new Date(value);
                let day = date.getDate();
                let month = date.getMonth() + 1;
                let year = date.getFullYear();
                let hours = date.getHours();
                let minutes = date.getMinutes();
                return `${day}/${month}/${year} ${hours}:${minutes}`;
            }
        },
        selectProduct(event, product) {
            this.selectedProduct = product;
            this.addProductModal.show();
        },
        confirmDeleteDialog(event, product) {
            this.selectedProduct = product;
            this.deleteModal.show();
        },
        openSingleProduct(product) {
            this.$inertia.visit(`/admin/products/${product.id}`)
        },

        submitSearch() {
            // this.$inertia.post(`/admin/products-search`, {
            //     search: this.search
            // },
            //     {
            //         preserveScroll: true,
            //         onSuccess: (page) => {
            //             // console.log(page);
            //             this.products_data = page;
            //         }
            //     });
            //use axios
            this.isLoading = true;
            axios.post(`/admin/products-search`, {
                search: this.search
            })
                .then((response) => {
                    console.log(response);
                    this.products_data = response.data;
                    this.isLoading = false;

                })
                .catch((error) => {
                    console.log(error);
                    this.isLoading = false;
                });
        },
    },

    watch: {
        products: {
            handler(newValue) {
                this.products_data = newValue;
            },
            deep: true
        }
    }
}
</script>

<template>
    <MainLayout>

        <div
            class="p-4 bg-white block sm:flex items-center justify-between border-b border-gray-200 lg:mt-1.5 dark:bg-gray-800 dark:border-gray-700">
            <div class="w-full mb-1">
                <div class="mb-4">
                    <BreadCrumb :title="'Stock/Products'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Products</h1>
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <form class="lg:pr-3" action="#" method="GET">
                            <label for="users-search" class="sr-only">Search</label>
                            <div class="relative mt-1 lg:w-64 xl:w-96">
                                <input type="text" name="email" id="users-search" v-model="search"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                    placeholder="Search for products by code or name">
                            </div>
                        </form>
                        <div class="flex pl-0 mt-3 space-x-1 sm:pl-2 sm:mt-0">
                            <button type="button" @click="submitSearch()"
                                class="inline-flex p-2 items-center text-sm font-medium text-center text-white text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                <svg class="w-6 h-6 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 20 20">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="downloadExcel()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">
                            <!-- <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg> -->
                            <i class="bi bi-download w-5 h-5 mr-2 -ml-1"></i>
                            Download Excel Template
                        </button>
                        <button type="button" @click="openUploadModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <!-- <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg> -->
                            <i class="bi bi-upload w-5 h-5 mr-2 -ml-1"></i>
                            Upload Excel
                        </button>
                        <button type="button" @click="openAddProductModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Add Product
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="overflow-hidden shadow">
                        <TableLayout :hasData="products.data.length > 0 ? true : false" :isLoading="isLoading">
                            <template v-slot:table>
                                <table class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
                                    <thead class="bg-gray-100 dark:bg-gray-700">
                                        <tr>
                                            <th scope="col" class="p-4">
                                                <div class="flex items-center">
                                                    <input id="checkbox-all" aria-describedby="checkbox-1" type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label for="checkbox-all" class="sr-only">checkbox</label>
                                                </div>
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Product Name
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Unit Measure
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Tax
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Category
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Retail Price
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Discount
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                            v-for="product in products_data.data">
                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input id="checkbox-194556" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label for="checkbox-194556" class="sr-only">checkbox</label>
                                                </div>
                                            </td>
                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">


                                                <img class="h-10 w-10 max-w-lg rounded-lg"
                                                    :src="`/storage/${product.image}`" alt="image description">

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">
                                                        {{ product.description }}</div>

                                                    <div class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span
                                                            class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                            {{ product.code }}

                                                        </span>
                                                        <CopyButton @click="copyToClipboard(product.code)" />
                                                    </div>
                                                </div>
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ product.unit_measure.name }}</td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                ${{ product.tax.rate }}</td>


                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ product.category.name }}
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                ${{ product.retail_unit_price }}
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                ${{ product.discount }}
                                            </td>

                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'product'" :has_view="true"
                                                    @delete="confirmDeleteDialog($event, product)"
                                                    @edit="selectProduct($event, product)"
                                                    @view="openSingleProduct(product)" />
                                            </td>
                                        </tr>


                                    </tbody>
                                </table>
                            </template>
                            <template v-slot:action-button>
                                <button @click="openAddProductModal()"
                                    class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>

                                    <span>Add Product</span>
                                </button>
                            </template>
                        </TableLayout>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="products_data.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="products_data.meta.from" :to="products_data.meta.to" :total="products_data.meta.total"
                :next_page_url="products_data.links.next" :prev_page_url="products_data.links.prev" />
        </div>

        <AddProductModal :unitMeasures="unitMeasures" :taxs="taxs" :categories="categories" :product="selectedProduct"
            @save="closeAddProductModal()" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteProduct" :type="'product'" />
        <UploadExcelProductsModal @close="closeUploadExcelModal" />
    </MainLayout>
</template>
