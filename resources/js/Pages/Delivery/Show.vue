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
    filters: {
        //currency filter
        currency(value) {
            return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(value);
        },
    },
    props: ['deliverySheet', 'deliveries', 'trucks', 'settings', 'warehouses', 'routes', 'users', 'allDrivers', 'allTrucks', 'sales', 'invoices', 'summary'],
    data() {
        return {
            selectedDetail: null,
            addDeliveryModal: null,
            viewDeliveryModal: null,
            updateDeliverySheetDetailModal: null,
            confirmDeliverySheetModal: null,
            editSheetModal: null,
            deleteModal: null,
            deleteCustomerStopModal: null,
            activeTab: 'deliveries',
            selectedDetail: null,
            isShowDeliverySheet: false,
            isShowEditSheet: false,
            isShowConfirmSheet: false,
            isShowCancelSheet: false,
            isShowCompleteSheet: false,
            canRemoveStock: true,
            confirmType: 'confirm',
            selectedCustomerStop: null,
            defaultCurrency: this.$page.props?.defaultCurrency,
            paymentBreakdowns: [],
            selectedDelivery: null,
            invoiceTotals: [],
            invoiceDiscounts: [],
            invoiceTaxes: [],
        }
    },
    mounted() {
        this.showConfirmSheet();
        this.showCancelSheet();
        this.showCompleteSheet()
        // this.setCanRemoveStock()
        this.getPaymentBreakDowns();
        const $targetElView = document.getElementById('view-delivery-modal');
        this.viewDeliveryModal = new Modal($targetElView);

        const $targetEl = document.getElementById('add-delivery-modal');
        this.addDeliveryModal = new Modal($targetEl);

        const $targetElConfirm = document.getElementById('confirm-delivery-sheet-modal');
        this.confirmDeliverySheetModal = new Modal($targetElConfirm);

        const $targetElEdit = document.getElementById('add-deliverySheet-modal');
        this.editSheetModal = new Modal($targetElEdit);

        const $targetElStock = document.getElementById('update-add-detail-stock');
        this.updateDeliverySheetDetailModal = new Modal($targetElStock);

        const $deleteCustomerStopModalEl = document.getElementById('delete-customer-modal');
        this.deleteCustomerStopModal = new Modal($deleteCustomerStopModalEl);

        const $deleteModalEl = document.getElementById('delete-deliverySheet-modal');
        this.deleteModal = new Modal($deleteModalEl);

    },
    filters: {
        formatField(value) {
            // Split the string at underscores, capitalize each word, and join with spaces
            return value.split('_').map(word => word.toUpperCase()).join(' ');
        }
    },

    methods: {
        getStatusBackGroundColor(status) {
            //switch case
            switch (status) {
                case 'Draft':
                    return 'bg-yellow-300 text-yellow-800';
                    break;
                case 'Pending':
                    return 'bg-green-500 text-white';
                    break;
                case 'Delivered':
                    return 'bg-blue-500 text-white';
                    break;
                case 'Cancelled':
                    return 'bg-gray-500 text-white';
                    break;
                default:
                    return 'bg-gray-500 text-white';
                    break;
            }
        },
        getPaymentBreakDowns() {
            const aggregatedTotalsList = [];
            const aggregatedDiscountList = [];
            const aggregatedTaxList = [];

            // if (!this.sales.data.totals) {
            //     return;
            // }

            // Iterate through the array
            this.invoices.data.forEach(item => {
                const totals = item.totals || {};
                const discount = item.discount || {};
                const tax = item.tax || {};

                // Iterate through the currencies in each "totals" object
                Object.entries(totals).forEach(([currency, amount]) => {
                    // Find the corresponding item in the aggregatedTotalsList array
                    const existingItem = aggregatedTotalsList.find(item => item.name === currency);

                    if (existingItem) {
                        // If the currency already exists, update the value
                        existingItem.value += amount;
                    } else {
                        // If the currency doesn't exist, add a new item
                        aggregatedTotalsList.push({ name: currency, value: amount });
                    }
                });
                Object.entries(discount).forEach(([currency, amount]) => {
                    // Find the corresponding item in the aggregatedTotalsList array
                    const existingItem = aggregatedDiscountList.find(item => item.name === currency);

                    if (existingItem) {
                        // If the currency already exists, update the value
                        existingItem.value += amount;
                    } else {
                        // If the currency doesn't exist, add a new item
                        aggregatedDiscountList.push({ name: currency, value: amount });
                    }
                });

                Object.entries(tax).forEach(([currency, amount]) => {
                    // Find the corresponding item in the aggregatedTotalsList array
                    const existingItem = aggregatedTaxList.find(item => item.name === currency);

                    if (existingItem) {
                        // If the currency already exists, update the value
                        existingItem.value += amount;
                    } else {
                        // If the currency doesn't exist, add a new item
                        aggregatedTaxList.push({ name: currency, value: amount });
                    }
                });



            });

            // return aggregatedTotalsList;
            this.invoiceTotals = aggregatedTotalsList;
            this.invoiceDiscounts = aggregatedDiscountList;
            this.invoiceTaxes = aggregatedTaxList;
        },
        openViewDeliveryModal(delivery) {
            this.selectedDelivery = delivery;
            this.viewDeliveryModal.show()
        },
        openAddDeliveryModal() {
            this.addDeliveryModal.show()
        },
        closeAddDeliveryModal() {
            this.addDeliveryModal.hide()
        },
        closeViewDeliveryModal() {
            this.selectedDelivery = null;
            this.viewDeliveryModal.hide()
        },
        openConfirmSheetModal(type) {
            this.confirmType = type
            this.confirmDeliverySheetModal.show();
        },
        closeConfirmSheetModal() {
            this.confirmDeliverySheetModal.hide();
        },
        openEditSheet() {
            this.editSheetModal.show();
        },
        closeEditSheet() {
            this.editSheetModal.hide();
        },

        closeDeleteModal() {
            this.deleteModal.hide();
        },

        selectDetail(event, detail) {
            this.selectedDetail = detail;
            this.openUpdateStockModal()
        },
        confirmRemoveDetail(event, detail) {
            this.selectedDetail = detail;
            this.deleteModal.show();
        },
        openSingleProduct(product) {
            this.$inertia.visit(`/company/products/${product.id}`)
        },
        toggleTab(id) {
            this.activeTab = id;
            if (id == 'deliveries') {
                document.getElementById('deliveries').classList.remove('hidden');
                document.getElementById('history').classList.add('hidden');
                document.getElementById('invoices').classList.add('hidden');
                document.getElementById('summary').classList.add('hidden');


            } else if (id == 'history') {
                document.getElementById('deliveries').classList.add('hidden');
                document.getElementById('invoices').classList.add('hidden');
                document.getElementById('summary').classList.add('hidden');
                document.getElementById('history').classList.remove('hidden');
            } else if (id == 'invoices') {
                document.getElementById('deliveries').classList.add('hidden');
                document.getElementById('history').classList.add('hidden');
                document.getElementById('summary').classList.add('hidden');
                document.getElementById('invoices').classList.remove('hidden');
            } else if (id == 'summary') {
                document.getElementById('deliveries').classList.add('hidden');
                document.getElementById('history').classList.add('hidden');
                document.getElementById('invoices').classList.add('hidden');
                document.getElementById('summary').classList.remove('hidden');
            }
        },

        getStatusIcon(status) {
            if (status == 'Draft') {
                return 'bi bi-journal-check text-red-400'
            } else if (status == 'Created') {
                return 'bi bi-check-circle text-green-400'
            } else if (status == 'Cancelled') {
                return 'bi bi-x-circle text-red-400'

            } else if (status == 'Loaded') {
                return 'bi bi-minecart-loaded text-green-400'

            } else if (status == 'Confirmed') {
                return 'bi bi-check-circle text-red-400'
            }
            else {
                return 'bi bi-exclamation-circle text-red-400'
            }
        },

        showDeliverySheet() {

            if (this.deliverySheet.data.status == 'Draft' || this.deliverySheet.data.status == 'Created' || this.deliverySheet.data.status == 'Loaded') {
                return this.isShowDeliverySheet = true;
            } else {
                return this.isShowDeliverySheet = false;
            }
        },
        showEditSheet() {
            //sheet can only be edited if it is in draft , created, loaded status
            if (this.deliverySheet.data.status == 'Draft' || this.deliverySheet.data.status == 'Created' || this.deliverySheet.data.status == 'Loaded') {
                return this.isShowEditSheet = true;
            } else {
                return this.isShowEditSheet = false;
            }
        },

        showConfirmSheet() {
            return this.isShowConfirmSheet = this.deliverySheet.data.status == 'Created';
        },

        showCompleteSheet() {
            return this.isShowCompleteSheet = this.deliverySheet.data.status == 'Confirmed' || this.deliverySheet.data.status == 'Started';
        },

        showCancelSheet() {
            //sheet can only be cancelled if it is loaded or draft or created
            if (this.deliverySheet.data.status == 'Completed' || this.deliverySheet.data.status == 'Cancelled') {
                return this.isShowCancelSheet = false;
            } else {
                return this.isShowCancelSheet = true;
            }
        },

        deleteDetail() {
            this.$inertia.post(`/company/delete-deliverySheet-detail`,
                {
                    detail_id: this.selectedDetail.id,
                },
                {
                    preserveScroll: true,
                    onSuccess: () => {
                        this.closeDeleteModal();
                    }
                });
        },



        confirmDeliverySheet() {
            if (this.confirmType == 'confirm') {
                this.$inertia.post(`/company/confirm-delivery-sheet`,
                    {
                        id: this.deliverySheet.data.id,
                    },
                    {
                        preserveScroll: true,
                        onSuccess: () => {
                            this.closeConfirmSheetModal();
                        }
                    });
            } else {
                this.$inertia.post(`/company/complete-delivery-sheet`,
                    {
                        id: this.deliverySheet.data.id,
                    },
                    {
                        preserveScroll: true,
                        onSuccess: () => {
                            this.closeConfirmSheetModal();
                        }
                    });
            }

        },

        setCanRemoveStock() {
            if (this.deliverySheet.data.status == 'Draft' || this.deliverySheet.data.status == 'Created' || this.deliverySheet.data.status == 'Loaded') {
                console.log(this.deliverySheet.data.status)
                this.canRemoveStock = true
            }
            this.canRemoveStock = false
        },


    },

    //watch for changes in deliverySheet
    watch: {
        deliverySheet: {
            handler(newValue) {
                console.log(newValue);
                this.showDeliverySheet();
                this.showEditSheet();
                this.showConfirmSheet();
                this.showCancelSheet();
                this.showCompleteSheet();
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
                    <BreadCrumb :title="`Delivery Sheets/${deliverySheet.data.id}`" />

                    <div className="flex">
                        <ul
                            className="mb-4 w-full text-xm mr-2 font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Status:</span>
                                <span className="w-3/4">
                                    <span :class="getStatusBackGroundColor(deliverySheet.data.status)"
                                        class="mb-4 w-20 text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                        {{ deliverySheet.data.status }}
                                    </span>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Created At:</span>
                                <span className="w-3/4">{{ deliverySheet.data.created_at }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Depart Date:</span>
                                <span className="w-3/4">{{ formatDateTime(deliverySheet.data.start_date_time) }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Driver:</span>
                                <span className="w-3/4">
                                    {{ deliverySheet.data.driver.first_name }} {{ deliverySheet.data.driver.last_name }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Driver Phone Number:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">

                                        <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ deliverySheet.data.driver.phone_number }}
                                        </p>
                                        <CopyButton @click="copyToClipboard(`${deliverySheet.data.route.start_lat} ${deliverySheet.data.route.start_lon}
   `)" />
                                    </div>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Driver Email:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">
                                        <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ deliverySheet.data.driver.email }}
                                        </p>
                                        <CopyButton @click="copyToClipboard(`${deliverySheet.data.driver.email}
                                   `)" />
                                    </div>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck Model:</span>
                                <span className="w-3/4">
                                    {{
                                        deliverySheet.data.truck.make_model }}

                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck License Plate:</span>
                                <span className="w-3/4">


                                    <div class="flex">
                                        <span
                                            class="flex bg-yellow-400 text-white border-2 border-black	 font-medium mr-2 px-3 py-1 rounded dark:bg-blue-900 dark:text-blue-300 ">
                                            {{ deliverySheet.data.truck.license_plate
                                            }}

                                        </span>
                                        <CopyButton @click="copyToClipboard(deliverySheet.data.truck.license_plate)" />
                                    </div>
                                </span>
                            </li>

                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck Mileage:</span>
                                <span className="w-3/4">
                                    {{ deliverySheet.data.truck.start_mileage }}km
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck Color:</span>
                                <span className="w-3/4">
                                    {{ deliverySheet.data.truck.color }}
                                </span>
                            </li>
                        </ul>

                        <ul
                            className="mb-4 w-full text-xm font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            <h4 class="text-lg p-3 font-semibold text-gray-900 border-b dark:text-white">Payments Breakdown
                            </h4>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Discount:</span>
                                <span className="w-3/4">
                                    <!-- <ConvertObject :currencyObject="invoiceTotals" /> -->

                                    <table
                                        class=" divide-y divide-gray-20 border border-gray-200 rounded-lg flex justify-between items-center dark:border-gray-6000">
                                        <!-- <thead>
          <tr>
            <th class="px-1 py-1 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Currency
            </th>
            <th class="px-1 py-1 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Value
            </th>
          </tr>
        </thead> -->
                                        <tbody>
                                            <tr v-for="(item) in invoiceDiscounts" :key="currency">
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ item.name }}
                                                </td>
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ formatMoney(item.value) }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Tax:</span>
                                <span className="w-3/4">
                                    <!-- <ConvertObject :currencyObject="invoiceTaxes" /> -->
                                    <table
                                        class=" divide-y divide-gray-20 border border-gray-200 rounded-lg flex justify-between items-center dark:border-gray-6000">

                                        <tbody>
                                            <tr v-for="(item) in invoiceTaxes" :key="invoice">
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ item.name }}
                                                </td>
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ formatMoney(item.value) }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Total:</span>
                                <span className="w-3/4">
                                    <!-- <ConvertObject :currencyObject="invoiceTotals" /> -->

                                    <table
                                        class=" divide-y divide-gray-20 border border-gray-200 rounded-lg flex justify-between items-center dark:border-gray-6000">

                                        <tbody>
                                            <tr v-for="(item) in invoiceTotals" :key="invoice">
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ item.name }}
                                                </td>
                                                <td class="px-1 py-1 whitespace-no-wrap">
                                                    {{ formatMoney(item.value) }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </span>
                            </li>
                        </ul>
                    </div>

                </div>
                <div class="sm:flex">
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3 ">
                        <button v-if="isShowEditSheet" type="button" @click="openEditSheet()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white  font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 focus:outline-none text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:focus:ring-yellow-900">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z">
                                </path>
                                <path fill-rule="evenodd"
                                    d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Edit Sheet
                        </button>

                        <button v-if="isShowDeliverySheet" type="button" @click="openAddDeliveryModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-purple-700 hover:bg-purple-800 focus:ring-4 focus:ring-purple-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-purple-600 dark:hover:bg-purple-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Add Delivery
                        </button>
                        <button v-if="isShowCompleteSheet" type="button" @click="openConfirmSheetModal('complete')"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <i class="bi bi-check-circle w-5 h-5 mr-2 -ml-1"></i>

                            Complete Sheet
                        </button>
                        <button v-if="isShowConfirmSheet" type="button" @click="openConfirmSheetModal('confirm')"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-green-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">

                            <i class="bi bi-check-circle w-5 h-5 mr-2 -ml-1"></i>
                            Confirm Sheet
                        </button>
                        <button v-if="isShowCancelSheet" type="button" @click="openAddDeliverySheetModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-red-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">

                            <i class="bi bi-x-circle w-5 h-5 mr-2 -ml-1"></i>
                            Cancel Sheet
                        </button>

                    </div>
                </div>
            </div>
        </div>
        <div class=" mb-4 border-b border-gray-200 dark:border-gray-700">
            <ul class="flex flex-wrap -mb-px text-sm font-medium text-center" role="tablist">
                <li class="mr-2">
                    <button class="inline-block p-4  rounded-t-lg text-base font-semibold" type="button"
                        :class="{ 'activeTab': activeTab == 'deliveries' }" @click="toggleTab('deliveries')">
                        Deliveries</button>
                </li>
                <li class="mr-2">
                    <button @click="toggleTab('history')" :class="{ 'activeTab': activeTab == 'history' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button"> History</button>
                </li>
                <li class="mr-2" v-if="deliverySheet.data.status === 'Completed'">
                    <button @click="toggleTab('invoices')" :class="{ 'activeTab': activeTab == 'invoices' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button"> Invoices</button>
                </li>
                <li class="mr-2" v-if="deliverySheet.data.status === 'Completed'">
                    <button @click="toggleTab('summary')" :class="{ 'activeTab': activeTab == 'summary' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button"> Summary</button>
                </li>

            </ul>
        </div>
        <div>
            <div class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="deliveries">
                <button type="button" @click="exportDeliverySheetDetails()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">
                    <!-- <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg> -->
                    <i class="bi bi-download w-5 h-5 mr-2 -ml-1"></i>
                    Export PDf
                </button>
                <button type="button" @click="downloadDeliverySheetDeatils()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">
                    <!-- <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg> -->
                    <i class="bi bi-download w-5 h-5 mr-2 -ml-1"></i>
                    Export Excel
                </button>
                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="deliveries.data.length > 0 ? true : false">
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
                                                        Location
                                                    </th>


                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Status
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Items
                                                    </th>

                                                    <!-- <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Discount
                                                    </th> -->
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                    v-for="detail in deliveries.data">

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
                                                        {{
                                                            detail.customer.address }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                        <span :class="getStatusBackGroundColor(detail.status)"
                                                            class="bg-green-500 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">
                                                            {{ detail.status }}
                                                        </span>
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{
                                                            detail.items.length }}
                                                    </td>


                                                    <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'detail'" :has_view="true"
                                                            @delete="confirmRemoveDetail($event, detail)"
                                                            @edit="selectDetail($event, detail)"
                                                            :has_delete="canRemoveStock" :has_edit="canRemoveStock"
                                                            @view="openViewDeliveryModal(detail)" />
                                                    </td>
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
                <div v-if="deliverySheet.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="deliverySheet.meta.from" :to="deliverySheet.meta.to"
                        :total="deliverySheet.meta.total" :next_page_url="deliverySheet.links.next"
                        :prev_page_url="deliverySheet.links.prev" />
                </div>

            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="invoices">
                <!-- <button type="button" @click="exportDeliverySheetDetails()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                    <i class="bi bi-download w-5 h-5 mr-2 -ml-1"></i>
                    Export PDf
                </button>
                <button type="button" @click="downloadDeliverySheetDeatils()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                    <i class="bi bi-download w-5 h-5 mr-2 -ml-1"></i>
                    Export Excel
                </button> -->
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

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
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
                <div v-if="deliverySheet.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="deliverySheet.meta.from" :to="deliverySheet.meta.to"
                        :total="deliverySheet.meta.total" :next_page_url="deliverySheet.links.next"
                        :prev_page_url="deliverySheet.links.prev" />
                </div>

            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="history">

                <ol class="relative border-l border-gray-200 dark:border-gray-700 m-2">
                    <li class="mb-10 ml-6" v-for="item in deliverySheet.data.history">
                        <span
                            class="absolute flex items-center justify-center w-6 h-6 bg-blue-100 rounded-full -left-3 ring-8 ring-white dark:ring-gray-900 dark:bg-blue-900">
                            <svg class="w-4 h-4  text-blue-800 dark:text-blue-300" aria-hidden="true"
                                xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                                <path
                                    d="M20 4a2 2 0 0 0-2-2h-2V1a1 1 0 0 0-2 0v1h-3V1a1 1 0 0 0-2 0v1H6V1a1 1 0 0 0-2 0v1H2a2 2 0 0 0-2 2v2h20V4ZM0 18a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V8H0v10Zm5-8h10a1 1 0 0 1 0 2H5a1 1 0 0 1 0-2Z" />
                            </svg>

                        </span>
                        <h3 class="flex items-center mb-1 text-lg font-semibold text-gray-900 dark:text-white">
                            {{ getTextPartFromDescription(item.description) }}<span
                                :class="getStatusBackGroundColor(deliverySheet.status)"
                                class="bg-blue-100 text-blue-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300 ml-3">{{
                                    item.status }}</span>
                        </h3>
                        <time class="block mb-2 text-sm font-semibold leading-none text-gray-400 dark:text-gray-500">Created
                            On {{ item.created_at }}</time>
                        <p class="mb-4 text-base font-semibold text-gray-500 dark:text-gray-400">
                            Actioned By {{ item.user.first_name }} {{ item.user.last_name }}
                            .</p>
                        <h5 class="flex items-center mb-1 text-lg font-semibold text-gray-900 dark:text-white"
                            v-if="item.status == 'Updated' && getDeliverySheetChangedFromDescription(item.description).length > 0">
                            Changes
                        </h5>
                        <div class="relative overflow-x-auto"
                            v-if="item.status == 'Updated' && getDeliverySheetChangedFromDescription(item.description).length > 0">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400 border rounded">
                                <thead
                                    class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th scope="col" class="px-6 py-3">
                                            Field
                                        </th>
                                        <th scope="col" class="px-6 py-3">
                                            Value
                                        </th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(change, index) in getDeliverySheetChangedFromDescription(item.description)"
                                        :key="index" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <th scope="row"
                                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            {{ formatField(Object.keys(change)[0]) }}
                                        </th>
                                        <td class="px-6 py-4">
                                            {{ Object.values(change)[0] }}
                                        </td>

                                    </tr>

                                </tbody>
                            </table>
                        </div>


                    </li>
                </ol>
            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="summary">
                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="summary.data.length > 0 ? true : false">
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
                                                        OutLoad Qty
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Total Sales Qty
                                                    </th>


                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Inload Qty
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Action
                                                    </th>

                                                    <!-- <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Discount
                                                    </th> -->

                                                </tr>

                                            </thead>
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                    v-for="detail in summary.data">

                                                    <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">


                                                        <img class="h-10 w-10 max-w-lg rounded-lg"
                                                            :src="`/storage/${detail.product.image}`"
                                                            alt="image description">

                                                        <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                            <div
                                                                class="text-base font-semibold text-gray-900 dark:text-white">
                                                                {{ detail.product.description }}</div>

                                                            <div
                                                                class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                                <span
                                                                    class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                                    {{ detail.product.code }}

                                                                </span>
                                                                <CopyButton @click="copyToClipboard(detail.product.code)" />
                                                            </div>
                                                        </div>
                                                    </td>

                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.total_outload_qty }} {{ detail.product.unit_measure.name
                                                        }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.total_sold_qty }} {{ detail.product.unit_measure.name }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.total_inload_qty }} {{ detail.product.unit_measure.name }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        <button type="button"
                                                            class="inline-flex items-center p-2 text-sm font-medium text-center text-white focus:outline-none text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300  rounded-lg dark:focus:ring-yellow-900">
                                                            <svg class="w-5 h-5 text-white dark:text-white"
                                                                aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                                                                fill="none" viewBox="0 0 24 24">
                                                                <path stroke="currentColor" stroke-linecap="round"
                                                                    stroke-linejoin="round" stroke-width="2"
                                                                    d="M17.7 7.7A7.1 7.1 0 0 0 5 10.8M18 4v4h-4m-7.7 8.3A7.1 7.1 0 0 0 19 13.2M6 20v-4h4" />
                                                            </svg>
                                                        </button>
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

            </div>

        </div>
        <!-- <AddDetailsDeliverySheet @save="closeAddStockModal" @close="closeAddStockModal"
            :deliverySheet="deliverySheet.data" />
        <UpdateAddStockDetailStock @save="closeUpdateStockModal" @close="closeUpdateStockModal"
            :deliverySheet="deliverySheet.data" :detail="selectedDetail" />
        <ConfirmDeleteDialog @yes="deleteDetail" :type="'deliverySheet'" @cancel="closeDeleteModal" />
        <ConfirmDeleteDialog @yes="removeCustomerStop" :type="'customer'" @cancel="closeDeleteModal" />
        <AddDeliverySheetModal :settings="settings" :deliverySheet="deliverySheet.data" :trucks="trucks"
            :warehouses="warehouses" :routes="routes" :users="users" @save="closeEditSheet()" />
        -->
        <ConfirmDeliverySheetModal :deliverySheet="deliverySheet.data" @save="closeConfirmSheetModal()"
            @yes="confirmDeliverySheet()" :type="confirmType" @close="closeConfirmSheetModal()" />
        <ViewDeliveryModal :delivery="selectedDelivery" @save="closeViewDeliveryModal()"
            @close="closeViewDeliveryModal()" />
        <AddDeliveryModal :deliverySheet="deliverySheet.data" @save="closeAddDeliveryModal()" :type="confirmType"
            @close="closeAddDeliveryModal()" />
    </MainLayout>
</template>

<style scoped>
.activeTab {
    border-bottom: 4px solid #2563EB;
}</style>
