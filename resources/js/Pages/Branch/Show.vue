<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
// import AddDetailsDeliverySheet from '@/Components/DeliverySheet/AddDetailsDeliverySheet.vue';
// import UpdateAddStockDetailStock from '@/Components/DeliverySheet/UpdateAddStockDetailStock.vue';
import ViewDeliveryModal from '@/Components/DeliverySheet/ViewDeliveryModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';
import AddDeliverySheetModal from '@/Components/DeliverySheet/AddDeliverySheetModal.vue';
import ConfirmDeliverySheetModal from '@/Components/DeliverySheet/ConfirmDeliverySheetModal.vue';
import AddDeliveryModal from '@/Components/DeliverySheet/AddDeliveryModal.vue';
import ConvertObject from '@/Components/ConvertObject.vue';
import TableLayout from '@/Components/TableLayout.vue';
import html2pdf from "html2pdf.js";
export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        // AddDetailsDeliverySheet,
        MainLayout,
        CopyButton,
        TableLayout,
        // UpdateAddStockDetailStock,
        UserCircleAvartar,
        AddDeliverySheetModal,
        AddDeliveryModal,
        ViewDeliveryModal,
        ConfirmDeliverySheetModal,
        ConvertObject
        // AddCustomerStopModal,
    },
    mixins: [globalMixin],

    props: ['branch', 'stock', 'invoices'],
    data() {
        return {
            activeTab: 'stock',
        }
    },
    mounted() {


    },


    methods: {

        navigateSingleInvoice(invoice) {
            this.$inertia.visit(`/company/invoices/${invoice.id}`)
        },
        toggleTab(id) {
            this.activeTab = id;
            if (id == 'stock') {
                document.getElementById('stock').classList.remove('hidden');
                document.getElementById('invoices').classList.add('hidden');
            } else if (id == 'invoices') {
                document.getElementById('stock').classList.add('hidden');
                document.getElementById('invoices').classList.remove('hidden');
            }
        },


    },

    //watch for changes in branch
    watch: {
        branch: {
            handler(newValue) {

            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
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
                    <BreadCrumb :title="`Branch/${branch.name}`" />

                    <div className="flex">
                        <ul
                            className="mb-4 w-full text-xm mr-2 font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Name:</span>
                                <span className="w-3/4">
                                    {{ branch.name }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Email:</span>
                                <span className="w-3/4">
                                    {{ branch.email }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Phone Number:</span>
                                <span className="w-3/4">
                                    {{ branch.phone_number }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Address:</span>
                                <span className="w-3/4">
                                    {{ branch.address }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Warehouse Address:</span>
                                <span className="w-3/4">
                                    {{ branch.warehouse.location }}
                                </span>
                            </li>




                        </ul>
                        <ul
                            className="mb-4 w-full text-xm mr-2 font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">

                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Default Cashier:</span>
                                <span className="w-3/4">
                                    {{ branch.user.first_name }} {{ branch.user.last_name }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Cashier Phone :</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">

                                        <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ branch.user.phone_number }}
                                        </p>
                                        <CopyButton @click="copyToClipboard(branch.user.phone_number)" />

                                    </div>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Cashier Email:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">
                                        <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ branch.user.email }}
                                        </p>
                                        <CopyButton @click="copyToClipboard(`${branch.user.email}
                                   `)" />
                                    </div>
                                </span>
                            </li>

                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Warehouse:</span>
                                <span className="w-3/4">
                                    {{ branch.warehouse.name }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Warehouse Code:</span>
                                <span className="w-3/4">
                                    {{ branch.warehouse.code }}
                                </span>
                            </li>


                        </ul>
                    </div>
                </div>
                <div class="sm:flex">
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3 ">

                    </div>
                </div>
            </div>
        </div>
        <div class=" mb-4 border-b border-gray-200 dark:border-gray-700">
            <ul class="flex flex-wrap -mb-px text-sm font-medium text-center" role="tablist">
                <li class="mr-2">
                    <button class="inline-block p-4  rounded-t-lg text-base font-semibold" type="button"
                        :class="{ 'activeTab': activeTab == 'stock' }" @click="toggleTab('stock')">
                        Stock</button>
                </li>
                <li class="mr-2">
                    <button @click="toggleTab('invoices')" :class="{ 'activeTab': activeTab == 'invoices' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button"> Invoices</button>
                </li>
            </ul>
        </div>
        <div>
            <div class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="stock">

                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="stock.data.length > 0 ? true : false">
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
                                                    <!-- <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Actions
                                                    </th> -->
                                                </tr>
                                            </thead>
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                    v-for="stock in stock.data">

                                                    <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">


                                                        <img class="h-10 w-10 max-w-lg rounded-lg"
                                                            :src="`/storage/${stock.product.image}`"
                                                            alt="image description">

                                                        <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                            <div
                                                                class="text-base font-semibold text-gray-900 dark:text-white">
                                                                {{ stock.product.description }}</div>

                                                            <div
                                                                class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
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
                                                        {{ stock.product?.default_price?.currency?.symbol }}{{
                                                            stock.product?.default_price?.retail_price }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                        {{ stock.product?.default_price?.currency?.symbol }}{{
                                                            stock.product?.default_price?.wholesale_price }}

                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{
                                                            stock.product?.default_price?.retail_price }}%
                                                    </td>

                                                    <!-- <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'stock'" :has_view="false"
                                                            @delete="confirmRemoveStock($event, stock)"
                                                            @edit="selectStock($event, stock)"
                                                            @view="openSingleProduct(stock.product)" />
                                                    </td> -->
                                                </tr>
                                            </tbody>
                                        </table>
                                    </template>

                                </TableLayout>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="stock.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="stock.meta.from" :to="stock.meta.to" :total="stock.meta.total"
                        :next_page_url="stock.links.next" :prev_page_url="stock.links.prev" />
                </div>

            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="invoices">

                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="invoices.data.length > 0 ? true : false">
                                    <template v-slot:table>
                                        <table class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
                                            <thead class="bg-gray-100 dark:bg-gray-700">
                                                <tr>

                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Customer
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Invoice Number
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Discount
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Tax
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Total
                                                    </th>

                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Status
                                                    </th>
                                                    <!-- <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Items
                                                    </th> -->

                                                    <!-- <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Discount
                                                    </th> -->
                                                    <!-- <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Actions
                                                    </th> -->
                                                </tr>
                                            </thead>
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr @click="navigateSingleInvoice(detail)"
                                                    class="hover:bg-gray-100 dark:hover:bg-gray-700 cursor-pointer"
                                                    v-for="detail in invoices.data">

                                                    <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">
                                                        <UserCircleAvartar :name="`${detail.customer.name}`" />

                                                        <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                            <div
                                                                class="text-base font-semibold text-gray-900 dark:text-white">
                                                                {{
                                                                    detail.customer.name }}
                                                            </div>
                                                            <div
                                                                class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                                {{
                                                                    detail.customer.email
                                                                }}
                                                            </div>
                                                        </div>
                                                    </td>


                                                    <td
                                                        class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                        <div
                                                            class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                            <span
                                                                class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                                {{ detail.invoice_number }}

                                                            </span>
                                                            <CopyButton @click="copyToClipboard(detail.invoice_number)" />
                                                        </div>

                                                    </td>
                                                    <td
                                                        class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        <ConvertObject :currencyObject="detail.discount" />
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                        <ConvertObject :currencyObject="detail.tax" />

                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                        <ConvertObject :currencyObject="detail.totals" />

                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                        <span :class="getStatusBackGroundColor(detail.status)"
                                                            class="bg-green-500 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">
                                                            {{ detail.status }}
                                                        </span>
                                                    </td>


                                                    <!-- <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'detail'" :has_view="true"
                                                            @delete="confirmRemoveDetail($event, detail)"
                                                            @edit="selectDetail($event, detail)"
                                                            :has_delete="canRemoveStock" :has_edit="canRemoveStock"
                                                            @view="openViewDeliveryModal(detail)" />
                                                    </td> -->
                                                </tr>
                                            </tbody>
                                        </table>
                                    </template>
                                    <template v-slot:action-button>
                                        <button @click="openAddDeliverySheetModal()"
                                            class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>

                                            <span>Add Items</span>
                                        </button>
                                    </template>
                                </TableLayout>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="invoices.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="invoices.meta.from" :to="invoices.meta.to" :total="invoices.meta.total"
                        :next_page_url="invoices.links.next" :prev_page_url="invoices.links.prev" />
                </div>
            </div>
        </div>
    </MainLayout>
</template>

<style scoped>
.activeTab {
    border-bottom: 4px solid #2563EB;
}</style>
