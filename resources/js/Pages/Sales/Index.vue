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
import Multiselect from 'vue-multiselect'
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';


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
        TableLayout,
        Multiselect,
        UserCircleAvartar
    },
    mixins: [globalMixin],

    props: ['sales', 'paymentMethods', 'currencies'],
    data() {
        return {

            sales_data: this.sales,
            search: '',
            isLoading: false,
            showSearchForm: true,
            paymentMethodsOptions: [],
            currenciesOptions: [],
            taxsOptions: [],
            statusOptions: [
                { id: 1, name: 'Paid' },
                { id: 2, name: 'Canceled' },
                { id: 3, name: 'Pending' }
            ],
            searchForm: {
                customer: '',
                order_number: '',
                date_range: null,
                paymentMethod: '',
                loadsheet: '',
                currency: [],
                status: [],
            },
            paymentsBreakdown: [],
        }
    },
    mounted() {
        this.updateOptions();

    },


    methods: {
        updateOptions() {
            this.paymentMethodsOptions = this.paymentMethods.map((method) => {
                return {
                    id: method.id,
                    name: method.name
                }
            });
            this.currenciesOptions = this.currencies.map((currency) => {
                return {
                    id: currency.id,
                    name: currency.name
                }
            });

        },
        returnFormatedName({ name }) {
            return name;
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


        openSingleSale(sale) {
            this.$inertia.visit(`/company/sales/${sale.id}`)
        },



        submitSearch() {

            this.isLoading = true;
            axios.post(`/company/filter-sales`, {
                customer: this.searchForm.customer,
                order_number: this.searchForm.order_number,
                loadsheet: this.searchForm.loadsheet,
                paymentMethod: this.searchForm.paymentMethod.name,
                from: this.searchForm.date_range ? this.searchForm.date_range[0] : null,
                to: this.searchForm.date_range ? this.searchForm.date_range[1] : null,
                currency: this.searchForm.currency ? this.searchForm.currency.map((currency) => currency.id) : [],
                status: this.searchForm.status ? this.searchForm.status.map(obj => obj.name) : [],
            })
                .then((response) => {
                    console.log(response);
                    this.sales_data = response.data;
                    this.isLoading = false;
                })
                .catch((error) => {
                    console.log(error);
                    this.isLoading = false;
                });
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
    },

    watch: {
        products: {
            handler(newValue) {
                this.sales_data = newValue;
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
                    <BreadCrumb :title="'Sales'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Sales</h1>
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <span
                            class="bg-purple-500 text-white text-medium font-medium mr-2 px-3 py-1 rounded dark:bg-purple-900 dark:text-purple-300">
                            {{ sales_data.meta.total }} records found</span>
                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="showSearchForm = !showSearchForm"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-4 focus:ring-green-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                            <i class=" w-5 h-5 mr-2 -ml-1"
                                :class="{ 'bi bi-dash-lg': showSearchForm, 'bi bi-plus-lg': !showSearchForm }"></i>
                            Hide Search Form
                        </button>

                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="grid gap-6 sm:grid-cols-4 sm:gap-6 m-4" v-if="showSearchForm">

                        <div class="w-full">
                            <label for="brand" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Payment
                                Methods</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="searchForm.paymentMethod" :options="paymentMethodsOptions" :multiple="false"
                                label="name" track-by="id" :custom-label="returnFormatedName">
                            </multiselect>
                        </div>
                        <div class="w-full">
                            <label for="price" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Unit of
                                Currencies</label>
                            <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                :multiple="true" v-model="searchForm.currency" :options="currenciesOptions"
                                :custom-label="returnFormatedName" label="name" track-by="id">
                            </multiselect>
                        </div>
                        <div class="w-full">
                            <label for="price"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Status</label>
                            <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                :multiple="true" v-model="searchForm.status" :options="statusOptions"
                                :custom-label="returnFormatedName" label="name" track-by="id">
                            </multiselect>
                        </div>
                        <div>
                            <label for="category" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Date
                                Range</label>
                            <Datepicker placeholder="Date Range"
                                class="z-20 block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="searchForm.date_range" range />
                        </div>
                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Order Number</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.order_number"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div class="">
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Customer</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.customer"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div class="">
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Loadsheet
                                Number</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.loadsheet"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>

                        <div class="">

                            <button type="button" @click="submitSearch()"
                                class="mt-7 inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                <i class="bi bi-search w-5 h-5 mr-2 -ml-1"></i>

                                Search
                            </button>

                        </div>
                    </div>

                    <div class="overflow-hidden shadow">
                        <TableLayout :hasData="sales_data.data.length > 0 ? true : false" :isLoading="isLoading">
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
                                                Customer
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Items
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Total
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Payment
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Created
                                            </th>


                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                            v-for="sale in sales_data.data">
                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input id="checkbox-194556" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label for="checkbox-194556" class="sr-only">checkbox</label>
                                                </div>
                                            </td>
                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">
                                                <UserCircleAvartar :name="sale.customer?.name ?? 'N/A'" />

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">{{
                                                        sale?.customer?.name }}
                                                    </div>
                                                    <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                                        sale?.customer?.email
                                                    }}
                                                    </div>
                                                </div>
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                <div class="flex-coulumn">
                                                    <h1 class="text-base font-semibold">
                                                        Items : {{ sale.details.length }}</h1>

                                                    <div
                                                        class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span class="text-xs font-medium text-gray-500">
                                                            Total synced: <strong>{{ sale.total_items_synced }} </strong>

                                                        </span>

                                                    </div>


                                                </div>
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <!-- {{ product.tax.rate }}% -->
                                                <div class="flex-coulumn">
                                                    <h1 class="text-base font-semibold">
                                                        Total: {{ sale.currency?.symbol }}{{ sale.total }}</h1>

                                                    <div
                                                        class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span class="text-xs font-medium text-gray-500">

                                                            Discount : {{ sale.currency?.symbol }}{{ sale.discount }}
                                                        </span>

                                                    </div>


                                                </div>
                                            </td>



                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <div class="flex-coulumn">
                                                    <h3 class="text-base font-semibold">
                                                        Status: <span :class="getStatusBackGroundColor(sale.status)"
                                                            class="bg-green-500 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">
                                                            {{ sale.status }}
                                                        </span></h3>

                                                    <div
                                                        class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span class="text-xs font-medium text-gray-500">
                                                            Payment Method: <strong>{{ sale.payment_method }}
                                                            </strong>

                                                        </span>

                                                    </div>
                                                </div>
                                            </td>
                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ sale.created_at }}
                                            </td>

                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'sale'" :has_view="true" :has_delete="false"
                                                    :has_edit="false" @view="openSingleSale(sale)" />
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
        <div v-if="sales_data.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="sales_data.meta.from" :to="sales_data.meta.to" :total="sales_data.meta.total"
                :next_page_url="sales_data.links.next" :prev_page_url="sales_data.links.prev" />
        </div>

    </MainLayout>
</template>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
