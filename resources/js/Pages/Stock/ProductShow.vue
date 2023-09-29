<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import AddProductModal from '@/Components/Warehouse/AddProductModal.vue';
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
        CopyButton
    },
    mixins: [globalMixin],

    props: ['product', 'categories', 'taxs', 'unitMeasures'],
    data() {
        return {
            addProductModal: null,

        }
    },
    mounted() {
        const $targetEl = document.getElementById('add-product-modal');
        this.addProductModal = new Modal($targetEl);



    },


    methods: {
        openAddWarehouseModal() {
            this.addProductModal.show();
        },

        closeAddProductModal() {
            this.addProductModal.hide();
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },



    },


};
</script>

<template>
    <MainLayout>

        <div
            class="p-4 bg-white block sm:flex items-center justify-between border-b border-gray-200 lg:mt-1.5 dark:bg-gray-800 dark:border-gray-700">
            <div class="w-full mb-1">
                <div class="mb-4">
                    <BreadCrumb :title="`Stock/${product.data.description}`" />
                    <div class="sm:flex">

                        <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                            <button type="button" @click="openAddWarehouseModal()"
                                class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                        clip-rule="evenodd"></path>
                                </svg>
                                Edit
                            </button>
                        </div>
                    </div>

                    <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">

                            <tbody>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Image
                                    </th>
                                    <td class="px-6 py-4">
                                        <img class="h-20 w-20 max-w-lg rounded-lg" :src="`/storage/${product.data.image}`"
                                            alt="image description">
                                    </td>

                                </tr>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white ">

                                        Description
                                    </th>
                                    <td class="px-6 py-4 flex flex-col">
                                        <!-- desc -->
                                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                                            {{ product.data.description }}
                                        </h3>
                                        <h6>{{ product.data.category.name }}</h6>

                                    </td>

                                </tr>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Product Code
                                    </th>
                                    <td class="px-6 py-4">
                                        <div class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                            <span
                                                class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                {{ product.data.code }}

                                            </span>
                                            <CopyButton @click="copyToClipboard(product.data.code)" />
                                        </div>
                                    </td>

                                </tr>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Retail Unit Price
                                    </th>
                                    <td class="px-6 py-4">
                                        ${{ product.data.retail_unit_price }}
                                    </td>

                                </tr>

                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Wholesale Unit Price
                                    </th>
                                    <td class="px-6 py-4">
                                        ${{ product.data.wholesale_unit_price }}
                                    </td>

                                </tr>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Reorder Level
                                    </th>
                                    <td class="px-6 py-4">
                                        {{ product.data.reorder_level }} units
                                    </td>

                                </tr>

                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Discount
                                    </th>
                                    <td class="px-6 py-4">
                                        {{ product.data.discount }}%
                                    </td>

                                </tr>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Unit of Measure
                                    </th>
                                    <td class="px-6 py-4">
                                        <span
                                            class="bg-yellow-100 text-yellow-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300">
                                            {{ product.data.unit_measure.name }}</span>
                                    </td>
                                </tr>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Tax
                                    </th>
                                    <td class="px-6 py-4">
                                        <span
                                            class="bg-yellow-100 text-yellow-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300">
                                            {{ product.data.tax.name }}</span>
                                        {{ product.data.tax.rate }}%
                                    </td>
                                </tr>
                                <tr class="bg-white border-b dark:bg-gray-900 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        Created At
                                    </th>
                                    <td class="px-6 py-4">
                                        {{ product.data.created_at }}
                                    </td>

                                </tr>


                            </tbody>
                        </table>
                    </div>

                    <!-- <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">{{ product.name }}</h1> -->
                </div>

            </div>
        </div>
        <AddProductModal :product="product.data" @save="closeAddProductModal()" :categories="categories" :taxs="taxs" :unitMeasures="unitMeasures" />

    </MainLayout>
</template>
