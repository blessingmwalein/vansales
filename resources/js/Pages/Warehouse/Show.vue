<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import AllocateStockModal from '@/Components/Warehouse/AllocateStockModal.vue';
import UpdateAllocateStock from '@/Components/Warehouse/UpdateAllocateStock.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";

import TableLayout from '@/Components/TableLayout.vue';
export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AllocateStockModal,
        MainLayout,
        CopyButton,
        TableLayout,
        UpdateAllocateStock
    },
    mixins: [globalMixin],

    props: ['warehouse', 'stocks'],
    data() {
        return {
            selectedStock: null,
            addStockModal: null,
            updateStockModal: null,
            deleteModal: null,
        }
    },
    mounted() {
        const $targetEl = document.getElementById('add-stock-modal');
        this.addStockModal = new Modal($targetEl);

        const $targetElStock = document.getElementById('update-allocate-stock');
        this.updateStockModal = new Modal($targetElStock);

        const $deleteModalEl = document.getElementById('delete-stock-modal');
        this.deleteModal = new Modal($deleteModalEl);

    },


    methods: {
        openAddStockModal() {
            this.addStockModal.show();
        },
        openUpdateStockModal() {
            this.updateStockModal.show();
        },

        closeAddStockModal() {
            this.addStockModal.hide();
        },
        closeUpdateStockModal() {
            this.updateStockModal.hide();
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },
        closeViewRoleModal() {
            this.viewRoleModal.hide();
        },
        deleteRole() {
            this.$inertia.delete(`/admin/users/warehouses/${this.selectedStock.id}`, {
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
        selectStock(event, stock) {
            console.log(stock);
            this.selectedStock = stock;
            this.updateStockModal.show();
        },
        confirmRemoveStock(event, stock) {
            this.selectedStock = stock;
            this.deleteModal.show();
        },
        openSingleProduct(product) {
            this.$inertia.visit(`/admin/products/${product.id}`)
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
                    <BreadCrumb :title="`Stock/${warehouse.name}`" />

                    <div class="flex items-center space-x-4">
                        <img class="h-20 w-20 max-w-lg rounded-lg" :src="`/storage/default.png`" alt="image description">
                        <div class="flex-1 min-w-0">
                            <!-- <p class="text-base font-semibold text-gray-900 truncate dark:text-white">
                                {{ warehouse.name }}
                            </p> -->
                            <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white"> {{ warehouse.name
                            }}</h1>
                            <p class="text-sm font-normal text-gray-500 truncate dark:text-gray-400">
                                {{ warehouse.location }}
                            </p>
                        </div>
                        <div class="inline-flex items-center">
                            <span
                                class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                {{ warehouse.code }}

                            </span>
                            <CopyButton @click="copyToClipboard(warehouse.code)" />
                        </div>
                    </div>
                    <!-- <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">{{ warehouse.name }}</h1> -->
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white"> Allocated Stock</h1>

                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="openAddStockModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Allocate Stock
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="overflow-hidden shadow">
                        <TableLayout :hasData="stocks.data.length > 0 ? true : false">
                            <template v-slot:table>
                                <table class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
                                    <thead class="bg-gray-100 dark:bg-gray-700">
                                        <tr>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Product Name
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Quantity
                                            </th>


                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Retail Price
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Wholesale Price
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

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700" v-for="stock in stocks.data">

                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">


                                                <img class="h-10 w-10 max-w-lg rounded-lg"
                                                    :src="`/storage/${stock.product.image}`" alt="image description">

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">
                                                        {{ stock.product.description }}</div>

                                                    <div class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span
                                                            class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                            {{ stock.product.code }}

                                                        </span>
                                                        <CopyButton @click="copyToClipboard(stock.product.code)" />
                                                    </div>
                                                </div>
                                            </td>


                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ stock.quantity }} {{ stock.product.unit_measure.name }}
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                ${{ stock.product.retail_unit_price }}
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                ${{ stock.product.wholesale_unit_price }}
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                ${{ stock.product.discount }}
                                            </td>

                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'stock'" :has_view="true"
                                                    @delete="confirmRemoveStock($event, stock)"
                                                    @edit="selectStock($event, stock)"
                                                    @view="openSingleProduct(stock.product)" />
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

                                    <span>Allocate Stock To Warehouse</span>
                                </button>
                            </template>
                        </TableLayout>

                    </div>
                </div>
            </div>
        </div>
        <div v-if="stocks.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="stocks.meta.from" :to="stocks.meta.to" :total="stocks.meta.total"
                :next_page_url="stocks.links.next" :prev_page_url="stocks.links.prev" />
        </div>
        <AllocateStockModal @save="closeAddStockModal" @close="closeAddStockModal" :warehouse="warehouse" />
        <UpdateAllocateStock @save="closeUpdateStockModal" @close="closeUpdateStockModal" :stock="selectedStock"
            :warehouse="warehouse" />
        <ConfirmDeleteDialog :type="'stock'" @cancel="closeDeleteModal" />
    </MainLayout>
</template>
