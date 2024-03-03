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
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';
import ConvertObject from '@/Components/ConvertObject.vue';

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
        UpdateAllocateStock,
        UserCircleAvartar,
        ConvertObject
    },
    mixins: [globalMixin],

    props: ['invoice', 'items'],
    data() {
        return {
        }
    },
    mounted() {
        // this.calcumatePayments();
    },


    methods: {

        navigateSingleInvoice(invoice) {
            this.$inertia.visit(`/company/invoices/${invoice.id}`)
        },

        getStatusBackGroundColor(status) {
            //switch case
            switch (status) {
                case 'Paid':
                    return 'bg-yellow-300 text-yellow-800';
                    break;
                case 'Pending':
                    return 'bg-green-500 text-white';
                    break;
                case 'Canceled':
                    return 'bg-red-500 text-white';
                    break;

                default:
                    return 'bg-gray-500 text-white';
                    break;
            }
        },

        openSingleProduct(product) {
            this.$inertia.visit(`/company/products/${product.id}`)
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
                    <BreadCrumb :title="`Invoice/${invoice.data.invoice_number}`" />

                    <div className="flex">
                        <ul
                            className="mb-4 w-full text-xm mr-2 font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            <li
                                className="w-full px-4 py-2 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Number:</span>
                                <span className="w-3/4">
                                    {{ invoice.data.invoice_number }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4  flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Status:</span>
                                <span className="w-3/4">
                                    <span :class="getStatusBackGroundColor(invoice.data.status)"
                                        class="mb-4 w-20 text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                        {{ invoice.data.status }}
                                    </span>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2  flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Created At:</span>
                                <span className="w-3/4">{{ formatDateTime(invoice.data.created_at) }}</span>
                            </li>

                            <h4 class="text-lg p-3 font-semibold text-gray-900 dark:text-white">Billed To
                            </h4>
                            <li
                                className="w-full px-4 py-2  flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Full Name:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1 items-center">
                                        <UserCircleAvartar
                                            :name="`${invoice.data?.customer?.name} `" />
                                        <p class=" ml-2 text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ invoice.data.customer.name }}
                                        </p>
                                    </div>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2  flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Address:</span>
                                <span className="w-3/4">
                                    {{ invoice.data.customer.address }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2  flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Email:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">
                                        <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ invoice.data.customer.email }}
                                        </p>
                                        <CopyButton @click="copyToClipboard(`${invoice.data.customer.email}
                                   `)" />
                                    </div>
                                </span>
                            </li>

                        </ul>

                        <ul
                            className="mb-4 w-full text-xm font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            <h4 class="text-lg p-3 font-semibold text-gray-900 dark:text-white">Payments Breakdown
                            </h4>
                            <li
                                className="w-full px-4 py-2 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Discount:</span>
                                <span className="w-3/4">
                                    <ConvertObject :currencyObject="invoice.data.discount" />

                                    <!-- <table
                                        class=" divide-y divide-gray-20 border border-gray-200 rounded-lg flex justify-between items-center dark:border-gray-6000">

                                        <tbody>
                                            <tr v-for="(item) in ">
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ item.name }}
                                                </td>
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ formatMoney(item.value) }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table> -->
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2  flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Tax:</span>
                                <span className="w-3/4">
                                    <ConvertObject :currencyObject="invoice.data.tax" />

                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2  flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Total:</span>
                                <span className="w-3/4">
                                    <ConvertObject :currencyObject="invoice.data.totals" />
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white"> Invoice Items</h1>

                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">

                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="overflow-hidden shadow">
                        <TableLayout :hasData="items.data.length > 0 ? true : false">
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
                                                Unit Price
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Total
                                            </th>


                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Created At
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700" v-for="item in items.data">

                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">


                                                <img class="h-10 w-10 max-w-lg rounded-lg"
                                                    :src="`/storage/${item?.stock.product.image}`" alt="image description">

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">
                                                        {{ item.stock.product.description }}</div>

                                                    <div class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span
                                                            class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                            {{ item.stock.product.code }}

                                                        </span>
                                                        <CopyButton @click="copyToClipboard(item.stock.product.code)" />
                                                    </div>
                                                </div>
                                            </td>


                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ item.quantity }} {{ item.stock.product.unit_measure.name }}
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{item.default_price.currency.code}}
                                                {{
                                                    item.default_price.retail_price}}
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{item.default_price.currency.code}}
                                                {{
                                                    item.default_price.retail_price * item.quantity }}
                                            </td>

                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{
                                                    formatDateTime(item.created_at) }}
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </template>

                        </TableLayout>

                    </div>
                </div>
            </div>
        </div>
        <div v-if="items.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="items.meta.from" :to="items.meta.to" :total="items.meta.total"
                :next_page_url="items.links.next" :prev_page_url="items.links.prev" />
        </div>
    </MainLayout>
</template>
