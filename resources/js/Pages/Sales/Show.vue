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
        UserCircleAvartar
    },
    mixins: [globalMixin],

    props: ['sale', 'details'],
    data() {
        return {
            paymentsBreakdown: [],
        }
    },
    mounted() {
        this.calcumatePayments();
    },


    methods: {


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

        calcumatePayments() {
            if (!this.sale.data.totals) {
                return;
            }
            const currenciesArray = Object.keys(this.sale.data.totals).map(currency => ({
                name: currency,
                value: this.sale.data.totals[currency]
            }));

            console.log(currenciesArray);
            this.paymentsBreakdown = currenciesArray;
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
                    <BreadCrumb :title="`Sale/${sale.data.order_number}`" />

                    <div class="flex items-center space-x-4">
                        <div class="flex-shrink-0">

                            <span :class="getStatusBackGroundColor(sale.data.status)"
                                class="mb-4 w-20 text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                {{ sale.data.payment_method }} : {{ sale.data.status }}
                            </span>
                            <span
                                class="flex bg-green-200 mb-4 mt-4 text-black text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                Created {{ sale.data.created_at }}
                            </span>


                        </div>
                        <div class="flex-1 min-w-0">
                            <!-- <div class="flex"> -->
                            <!-- <UserCircleAvartar :name="sale.data.customer.name" /> -->

                            <div class="ml-3 text-sm font-normal text-gray-500 dark:text-gray-400">
                                <div class="text-base font-semibold text-gray-900 dark:text-white">{{
                                    sale.data?.customer?.name }}
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                    sale.data?.customer?.email
                                }}
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                    sale.data?.customer?.phone_number
                                }}
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                    sale.data?.customer?.address
                                }}
                                </div>
                                <!-- </div> -->

                            </div>
                        </div>
                        <div class="flex-1 min-w-0">
                            <!-- <div class="flex"> -->
                            <!-- <UserCircleAvartar :name="sale.data.customer.name" /> -->

                            <div class="ml-3 text-sm font-normal text-gray-500 dark:text-gray-400">
                                <div class="text-base font-semibold text-gray-900 dark:text-white">
                                    Load Sheet : <strong>{{ sale.data.loadsheet.loadsheet_number }}</strong>
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                    Start Date : <strong> {{ sale.data.loadsheet.start_date_time }}</strong>
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                    Driver :<strong>{{ sale.data.driver.first_name }} {{ sale.data.driver.last_name
                                    }}</strong>
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                    Driver Phone :<strong>{{ sale.data.driver.phone_number
                                    }}</strong>
                                </div>

                                <!-- </div> -->

                            </div>
                        </div>
                        <div class="flex-1 min-w-0">
                            <!-- <div class="flex"> -->
                            <!-- <UserCircleAvartar :name="sale.data.customer.name" /> -->

                            <div class="ml-3 text-sm font-normal text-gray-500 dark:text-gray-400">
                                <div class="text-base font-semibold text-gray-900 dark:text-white">
                                    Total : <strong>${{
                                        sale.data?.total }}</strong>
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                    Tax : <strong> ${{
                                        sale.data?.tax
                                    }}</strong>
                                </div>
                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                    Discount :<strong>${{ sale.data.discount }}</strong>
                                </div>
                                <!-- <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                    Currency :<strong>{{ sale.data.currency.name }}</strong>
                                </div> -->

                                <!-- </div> -->

                            </div>
                        </div>
                    </div>
                    <!-- <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">{{ warehouse.name }}</h1> -->
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
                        <TableLayout :hasData="details.data.length > 0 ? true : false">
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
                                                Total
                                            </th>


                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Created At
                                            </th>

                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700" v-for="item in details.data">

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
                                                ${{
                                                    item.total_price }}
                                            </td>

                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{
                                                    item.created_at }}
                                            </td>


                                        </tr>
                                        <tr class="bg-gray-100 dark:bg-gray-700">

                                            <th scope="col"
                                                class="p-4 font-bold text-left text-black uppercase dark:text-gray-400">
                                                Payments Breakdowns
                                            </th>

                                        </tr>
                                        <tr class="bg-gray-100 dark:bg-gray-700" v-for="payment in paymentsBreakdown">

                                            <th scope="col"
                                                class="p-4 font-bold text-left text-black uppercase dark:text-gray-400">
                                                {{ payment.name }}
                                            </th>
                                            <th scope="col" class="p-4 font-bold text-left text-black  dark:text-gray-400">
                                                {{ formatMoney(payment.value, payment.name) }}
                                            </th>

                                        </tr>
                                    </tbody>
                                </table>
                            </template>

                        </TableLayout>

                    </div>
                </div>
            </div>
        </div>
        <div v-if="details.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="details.meta.from" :to="details.meta.to" :total="details.meta.total"
                :next_page_url="details.links.next" :prev_page_url="details.links.prev" />
        </div>

    </MainLayout>
</template>
