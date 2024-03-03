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
import ConvertObject from '@/Components/ConvertObject.vue';



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
        UserCircleAvartar,
        ConvertObject
    },
    mixins: [globalMixin],

    props: ['invoices', 'branches'],
    data() {
        return {

            invoices_data: this.invoices,
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
            typeOptions: [
                'Delivery',
                'LoadSheet',
                'Branch'
            ],
            branchOptions: [],
            searchForm: {
                customer: '',
                type: 'LoadSheet',
                invoice_number: '',
                date_range: null,
                // paymentMethod: '',
                loadsheet: '',
                branch: '',
                delivery: '',
                // currency: [],
                status: [],
            },
            paymentsBreakdown: [],
        }
    },
    mounted() {
        this.updateOptions();

    },


    methods: {
        navigateSingleInvoice(invoice) {
            this.$inertia.visit(`/company/invoices/${invoice.id}`)
        },
        updateOptions() {

            this.branchOptions = this.branches.map((branch) => {
                return {
                    id: branch.id,
                    name: branch.name
                }
            });

            // this.paymentMethodsOptions = this.paymentMethods.map((method) => {
            //     return {
            //         id: method.id,
            //         name: method.name
            //     }
            // });
            // this.currenciesOptions = this.currencies.map((currency) => {
            //     return {
            //         id: currency.id,
            //         name: currency.name
            //     }
            // });

        },
        returnFormatedName({ name }) {
            return name;
        },


        openSingleSale(sale) {
            this.$inertia.visit(`/company/invoices/${sale.id}`)
        },


        submitSearch() {

            this.isLoading = true;
            axios.post(`/company/filter-invoices`, {
                customer: this.searchForm.customer,
                invoice_number: this.searchForm.invoice_number,
                type: this.searchForm.type,
                loadsheet: this.searchForm.loadsheet,
                branch: this.searchForm.branch?.id,
                delivery: this.searchForm.delivery,
                // paymentMethod: this.searchForm.paymentMethod.name,
                from: this.searchForm.date_range ? this.searchForm.date_range[0] : null,
                to: this.searchForm.date_range ? this.searchForm.date_range[1] : null,
                status: this.searchForm.status ? this.searchForm.status.map(obj => obj.name) : [],
            })
                .then((response) => {
                    console.log(response);
                    this.invoices_data = response.data;
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

        getFieldName() {
            return this.searchForm?.type?.toLowerCase();
        }
    },

    watch: {
        products: {
            handler(newValue) {
                this.invoices_data = newValue;
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
                            {{ invoices_data.meta.total }} records found</span>
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
                            <label for="brand"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Type</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="searchForm.type" :options="typeOptions" :multiple="false">
                            </multiselect>
                        </div>
                        <!-- <div class="w-full">
                            <label for="price" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Unit of
                                Currencies</label>
                            <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                :multiple="true" v-model="searchForm.currency" :options="currenciesOptions"
                                :custom-label="returnFormatedName" label="name" track-by="id">
                            </multiselect>
                        </div> -->
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
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Invoice Number</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.invoice_number"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div class="">
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Customer</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.customer"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div class="">
                            <label for="description" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">{{
                                searchForm.type }}</label>
                            <input type="text" v-if="searchForm.type !== 'Branch'" name="email" id="users-search"
                                v-model="searchForm[getFieldName()]"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                            <multiselect v-else class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                :multiple="false" v-model="searchForm.branch" :options="branchOptions" label="name"
                                track-by="id">
                            </multiselect>
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
                        <TableLayout :hasData="invoices_data.data.length > 0 ? true : false">
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
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr @click="navigateSingleInvoice(detail)"
                                            class="hover:bg-gray-100 dark:hover:bg-gray-700 cursor-pointer"
                                            v-for="detail in invoices_data.data">

                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">
                                                <UserCircleAvartar :name="`${detail.customer.name}`" />

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">
                                                        {{
                                                            detail.customer.name }}
                                                    </div>
                                                    <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        {{
                                                            detail.customer.email
                                                        }}
                                                    </div>
                                                </div>
                                            </td>


                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                <div class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
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

                        </TableLayout>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="invoices_data.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="invoices_data.meta.from" :to="invoices_data.meta.to" :total="invoices_data.meta.total"
                :next_page_url="invoices_data.links.next" :prev_page_url="invoices_data.links.prev" />
        </div>

    </MainLayout>
</template>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
