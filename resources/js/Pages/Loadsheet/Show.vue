<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import AddDetailsLoadSheet from '@/Components/Loadsheet/AddDetailsLoadSheet.vue';
import UpdateAddStockDetailStock from '@/Components/Loadsheet/UpdateAddStockDetailStock.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';
import AddLoadSheetModal from '@/Components/Loadsheet/AddLoadSheetModal.vue';
import ConfirmLoadSheetModal from '@/Components/Loadsheet/ConfirmLoadSheetModal.vue';
import AddCustomerStopModal from '@/Components/Loadsheet/AddCustomerStopModal.vue';
import TableLayout from '@/Components/TableLayout.vue';
import ConvertObject from '@/Components/ConvertObject.vue';

import html2pdf from "html2pdf.js";
export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddDetailsLoadSheet,
        MainLayout,
        CopyButton,
        TableLayout,
        UpdateAddStockDetailStock,
        UserCircleAvartar,
        AddLoadSheetModal,
        ConfirmLoadSheetModal,
        AddCustomerStopModal,
        ConvertObject
    },
    mixins: [globalMixin],
    filters: {
        //currency filter
        currency(value) {
            return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(value);
        },
    },
    props: ['paymentsBreakdown', 'loadsheet', 'details', 'trucks', 'settings', 'summary', 'invoices', 'summary', 'warehouses', 'routes', 'users', 'allDrivers', 'allTrucks', 'sales'],
    data() {
        return {
            selectedDetail: null,
            addLoadSheetDetail: null,
            updateLoadSheetDetailModal: null,
            confirmLoadSheetModal: null,
            editSheetModal: null,
            deleteModal: null,
            deleteCustomerStopModal: null,
            activeTab: 'details',
            selectedDetail: null,
            isShowLoadSheet: false,
            isShowEditSheet: false,
            isShowConfirmSheet: false,
            isShowCancelSheet: false,
            isShowCompleteSheet: false,
            canRemoveStock: true,
            confirmType: 'confirm',
            selectedCustomerStop: null,
            defaultCurrency: this.$page.props?.defaultCurrency,
            paymentBreakdowns: [],
            invoiceTotals: [],
            invoiceDiscounts: [],
            invoiceTaxes: [],
        }
    },
    mounted() {
        this.showLoadSheet();
        this.showEditSheet();
        this.showConfirmSheet();
        this.showCancelSheet();
        this.showCompleteSheet()
        // this.setCanRemoveStock()
        this.getPaymentBreakDowns();
        const $targetEl = document.getElementById('add-details-loadsheet-modal');
        this.addLoadSheetDetail = new Modal($targetEl);

        const $targetElConfirm = document.getElementById('confirm-loadsheet-modal');
        this.confirmLoadSheetModal = new Modal($targetElConfirm);

        const $targetElEdit = document.getElementById('add-loadsheet-modal');
        this.editSheetModal = new Modal($targetElEdit);

        const $targetElStock = document.getElementById('update-add-detail-stock');
        this.updateLoadSheetDetailModal = new Modal($targetElStock);

        const $deleteCustomerStopModalEl = document.getElementById('delete-customer-modal');
        this.deleteCustomerStopModal = new Modal($deleteCustomerStopModalEl);

        const $deleteModalEl = document.getElementById('delete-loadsheet-modal');
        this.deleteModal = new Modal($deleteModalEl);


        const $addCustomerStop = document.getElementById('add-customer-stop-modal');
        this.addCustomerModal = new Modal($addCustomerStop);
    },
    filters: {
        formatField(value) {
            // Split the string at underscores, capitalize each word, and join with spaces
            return value.split('_').map(word => word.toUpperCase()).join(' ');
        }
    },

    methods: {
        openAddCustomerStopModal() {
            this.addCustomerModal.show()
        },
        closeAddCustomerStopModal() {
            this.addCustomerModal.hide()
        },
        openAddLoadSheetModal() {
            this.addLoadSheetDetail.show();
        },
        openConfirmSheetModal(type) {
            this.confirmType = type
            this.confirmLoadSheetModal.show();
        },
        closeConfirmSheetModal() {
            this.confirmLoadSheetModal.hide();
        },
        openEditSheet() {
            this.editSheetModal.show();
        },
        closeEditSheet() {
            this.editSheetModal.hide();
        },
        closeAddStockModal() {
            this.addLoadSheetDetail.hide();
        },

        openUpdateStockModal() {
            this.updateLoadSheetDetailModal.show();
        },
        closeUpdateStockModal() {
            this.updateLoadSheetDetailModal.hide();
        },

        closeDeleteModal() {
            this.deleteModal.hide();
        },
        closeDeleteCustomerStopModal() {
            this.deleteCustomerStopModal.hide();
        },
        openDeleteCustomerStopModal(customerStop) {
            this.selectedCustomerStop = customerStop;
            this.deleteCustomerStopModal.show();
        },

        selectDetail(event, detail) {
            console.log(detail);
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
            if (id == 'details') {
                document.getElementById('details').classList.remove('hidden');
                document.getElementById('history').classList.add('hidden');
                document.getElementById('customers').classList.add('hidden');
                document.getElementById('summary').classList.add('hidden');
                document.getElementById('invoices').classList.add('hidden');

            } else if (id == 'history') {
                document.getElementById('details').classList.add('hidden');
                document.getElementById('customers').classList.add('hidden');
                document.getElementById('summary').classList.add('hidden');
                document.getElementById('invoices').classList.add('hidden');


                document.getElementById('history').classList.remove('hidden');
            } else if (id == 'customers') {
                document.getElementById('details').classList.add('hidden');
                document.getElementById('history').classList.add('hidden');
                document.getElementById('summary').classList.add('hidden');
                document.getElementById('customers').classList.remove('hidden');
                document.getElementById('invoices').classList.add('hidden');

            }
            else if (id == 'summary') {
                document.getElementById('details').classList.add('hidden');
                document.getElementById('history').classList.add('hidden');
                document.getElementById('customers').classList.add('hidden');
                document.getElementById('summary').classList.remove('hidden');
                document.getElementById('invoices').classList.add('hidden');

            }
            else if (id == 'invoices') {
                document.getElementById('details').classList.add('hidden');
                document.getElementById('history').classList.add('hidden');
                document.getElementById('customers').classList.add('hidden');
                document.getElementById('summary').classList.add('hidden');
                document.getElementById('invoices').classList.remove('hidden');

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

        showLoadSheet() {

            if (this.loadsheet.data.status == 'Draft' || this.loadsheet.data.status == 'Created' || this.loadsheet.data.status == 'Loaded') {
                return this.isShowLoadSheet = true;
            } else {
                return this.isShowLoadSheet = false;
            }
        },
        showEditSheet() {
            //sheet can only be edited if it is in draft , created, loaded status
            if (this.loadsheet.data.status == 'Draft' || this.loadsheet.data.status == 'Created' || this.loadsheet.data.status == 'Loaded') {
                return this.isShowEditSheet = true;
            } else {
                return this.isShowEditSheet = false;
            }
        },

        showConfirmSheet() {
            //sheet can only be confirmed if it is loaded
            if (this.loadsheet.data.status == 'Loaded') {
                return this.isShowConfirmSheet = true;
            } else {
                return this.isShowConfirmSheet = false;
            }
        },

        showCompleteSheet() {
            //sheet can only be confirmed if it is loaded
            if (this.loadsheet.data.status == 'Confirmed' || this.loadsheet.data.status == 'Started') {
                return this.isShowCompleteSheet = true;
            } else {
                return this.isShowCompleteSheet = false;
            }
        },

        showCancelSheet() {
            //sheet can only be cancelled if it is loaded or draft or created
            if (this.loadsheet.data.status == 'Completed' || this.loadsheet.data.status == 'Cancelled') {
                return this.isShowCancelSheet = false;
            } else {
                return this.isShowCancelSheet = true;
            }
        },
        deleteDetail() {
            this.$inertia.post(`/company/delete-loadsheet-detail`,
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
        removeCustomerStop() {
            this.$inertia.post(`/company/remove-customer-stop`,
                {
                    customer_stop_id: this.selectedCustomerStop.id,
                },
                {
                    preserveScroll: true,
                    onSuccess: () => {
                        this.closeDeleteCustomerStopModal();
                    }
                });
        },

        confirmLoadSheet() {
            if (this.confirmType == 'confirm') {
                this.$inertia.post(`/company/confirm-loadsheet`,
                    {
                        load_sheet_id: this.loadsheet.data.id,
                    },
                    {
                        preserveScroll: true,
                        onSuccess: () => {
                            this.closeConfirmSheetModal();
                        }
                    });
            } else {
                this.$inertia.post(`/company/complete-loadsheet`,
                    {
                        load_sheet_id: this.loadsheet.data.id,
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
            if (this.loadsheet.data.status == 'Draft' || this.loadsheet.data.status == 'Created' || this.loadsheet.data.status == 'Loaded') {
                console.log(this.loadsheet.data.status)
                this.canRemoveStock = true
            }
            this.canRemoveStock = false
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

        exportLoadSheetCustomers() {
            // Get the elements to be exported
            const loadsheetCustomers = document.getElementById('customers');

            // Create a container element
            const container = document.createElement('div');

            // Append the content of each element to the container
            container.appendChild(loadSheetInfor.cloneNode(true));
            container.appendChild(loadsheetCustomers.cloneNode(true));

            // Export the container to a PDF
            html2pdf(container, {
                margin: 0,
                filename: "loadsheet.pdf",
                image: { type: 'jpeg', quality: 1 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', orientation: 'landscape' }
            });
        },

        exportLoadSheetDetails() {
            const loadSheetInfor = document.getElementById('load-sheet-infor');
            const loadSheetDetails = document.getElementById('details');
            const container = document.createElement('div');

            // Append the content of each element to the container
            container.appendChild(loadSheetInfor.cloneNode(true));
            container.appendChild(loadSheetDetails.cloneNode(true));

            // Export the container to a PDF
            html2pdf(container, {
                margin: 0,
                filename: `${`loadsheet-${this.loadsheet.data.loadsheet_number}-details`}.pdf`,
                image: { type: 'jpeg', quality: 1 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', orientation: 'landscape' }
            });

        },

        exportLoadSheetSummary() {
            const loadsheetSummary = document.getElementById('summary');
            const container = document.createElement('div');

            // Append the content of each element to the container
            container.appendChild(loadSheetInfor.cloneNode(true));
            container.appendChild(loadsheetSummary.cloneNode(true));

            // Export the container to a PDF
            html2pdf(container, {
                margin: 0,
                filename: `${`loadsheet-${this.loadsheet.data.loadsheet_number}-summary`}.pdf`,
                image: { type: 'jpeg', quality: 1 },
                html2canvas: { scale: 2 },
                jsPDF: { unit: 'in', orientation: 'landscape' }
            });
        },

        downLoadSheetSummary() {
            //post to server to generateexcel
            //create download link from its get admin/download-loadsheet-summary?loadsheet_id=8 and click it
            // this.$inertia.get(`/company/download-loadsheet-summary?loadsheet_id=${this.loadsheet.data.id}`)

            window.open(`/company/download-loadsheet-summary?loadsheet_id=${this.loadsheet.data.id}`, '_blank');

        },
        downloadLoadSheetDeatils() {
            //post to server to generateexcel
            //create download link from its get admin/download-loadsheet-summary?loadsheet_id=8 and click it
            // this.$inertia.get(`/company/download-loadsheet-summary?loadsheet_id=${this.loadsheet.data.id}`)

            window.open(`/company/download-loadsheet-details?loadsheet_id=${this.loadsheet.data.id}`, '_blank');

        }
    },

    //watch for changes in loadsheet
    watch: {
        loadsheet: {
            handler(newValue) {
                console.log(newValue);
                this.showLoadSheet();
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
                    <BreadCrumb :title="`Loadsheets/${loadsheet.data.loadsheet_number}`" />
                    <div className="flex">
                        <ul
                            className="mb-4 w-full text-xm mr-2 font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Status:</span>
                                <span className="w-3/4">
                                    <span :class="getStatusBackGroundColor(loadsheet.data.status)"
                                        class="mb-4 w-20 text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                        {{ loadsheet.data.status }}
                                    </span>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Created At:</span>
                                <span className="w-3/4">{{ loadsheet.data.created_at }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Depart Date:</span>
                                <span className="w-3/4">{{ formatDateTime(loadsheet.data.start_date_time) }}</span>
                            </li>

                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck Model:</span>
                                <span className="w-3/4">
                                    {{
                                        loadsheet.data.truck.make_model }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck License Plate:</span>
                                <span className="w-3/4">


                                    <div class="flex">
                                        <span
                                            class="flex bg-yellow-400 text-white border-2 border-black	 font-medium mr-2 px-3 py-1 rounded dark:bg-blue-900 dark:text-blue-300 ">
                                            {{ loadsheet.data.truck.license_plate
                                            }}

                                        </span>
                                        <CopyButton @click="copyToClipboard(loadsheet.data.truck.license_plate)" />
                                    </div>
                                </span>
                            </li>

                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck Mileage:</span>
                                <span className="w-3/4">
                                    {{ loadsheet.data.truck.start_mileage }}km
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Truck Color:</span>
                                <span className="w-3/4">
                                    {{ loadsheet.data.truck.color }}
                                </span>
                            </li>
                        </ul>
                        <ul
                            className="mb-4 w-full text-xm font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">


                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Driver:</span>
                                <span className="w-3/4">
                                    {{ loadsheet.data.user.first_name }} {{ loadsheet.data.user.last_name }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Driver Phone Number:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">

                                        <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ loadsheet.data.user.phone_number }}
                                        </p>
                                        <CopyButton @click="copyToClipboard(loadsheet.data.user.phone_number)" />
                                    </div>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Driver Email:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">
                                        <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                            {{ loadsheet.data.user.email }}
                                        </p>
                                        <CopyButton @click="copyToClipboard(`${loadsheet.data.user.email}
                                   `)" />
                                    </div>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Route Name:</span>
                                <span className="w-3/4">
                                    {{
                                        loadsheet.data.route.name }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Warehouse Name:</span>
                                <span className="w-3/4">
                                    {{ loadsheet.data.warehouse.name }}
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Warehouse Code:</span>
                                <span className="w-3/4">
                                    <div class="flex mt-1">
                                        <span
                                            class="flex bg-blue-400 text-white text-sm mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                            {{ loadsheet.data.warehouse.code
                                            }}

                                        </span>
                                        <CopyButton @click="copyToClipboard(loadsheet.data.warehouse.code)" />
                                    </div>

                                </span>
                            </li>
                        </ul>
                    </div>
                    <div class="flex">
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


                    <!-- <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">{{ loadsheet.data.name }}</h1> -->
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
                            Edit Load Sheet
                        </button>
                        <button v-if="isShowLoadSheet" type="button" @click="openAddLoadSheetModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Load Sheet
                        </button>
                        <button v-if="isShowLoadSheet" type="button" @click="openAddCustomerStopModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-purple-700 hover:bg-purple-800 focus:ring-4 focus:ring-purple-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-purple-600 dark:hover:bg-purple-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Customer Stop
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
                        <button v-if="isShowCancelSheet" type="button" @click="openAddLoadSheetModal()"
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
                        :class="{ 'activeTab': activeTab == 'details' }" @click="toggleTab('details')">
                        Items</button>
                </li>
                <li class="mr-2">
                    <button @click="toggleTab('history')" :class="{ 'activeTab': activeTab == 'history' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button"> History</button>
                </li>
                <li class="mr-2">
                    <button @click="toggleTab('customers')" :class="{ 'activeTab': activeTab == 'customers' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button"> Customer Stops</button>
                </li>
                <li class="mr-2" v-if="loadsheet.data.status == 'Completed'">
                    <button @click="toggleTab('summary')" :class="{ 'activeTab': activeTab == 'summary' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button">Summary</button>
                </li>
                <li class="mr-2" v-if="loadsheet.data.status == 'Completed'">
                    <button @click="toggleTab('invoices')" :class="{ 'activeTab': activeTab == 'invoices' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button">Invoices</button>
                </li>

            </ul>
        </div>
        <div>
            <div class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="details">
                <button type="button" @click="exportLoadSheetDetails()"
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
                <button type="button" @click="downloadLoadSheetDeatils()"
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
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                    v-for="detail in details.data">

                                                    <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">


                                                        <img class="h-10 w-10 max-w-lg rounded-lg"
                                                            :src="`/storage/${detail.stock.product.image}`"
                                                            alt="image description">

                                                        <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                            <div
                                                                class="text-base font-semibold text-gray-900 dark:text-white">
                                                                {{ detail.stock.product.description }}</div>

                                                            <div
                                                                class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                                <span
                                                                    class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                                    {{ detail.stock.product.code }}

                                                                </span>
                                                                <CopyButton
                                                                    @click="copyToClipboard(detail.stock.product.code)" />
                                                            </div>
                                                        </div>
                                                    </td>


                                                    <td
                                                        class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.quantity }} {{ detail.stock.product.unit_measure.name }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.default_price?.currency?.symbol }}{{
                                                            detail.default_price.retail_price }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.default_price?.currency?.symbol }}{{
                                                            detail.default_price.wholesale_price }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{
                                                            detail.default_price.discount }}%
                                                    </td>

                                                    <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'detail'" :has_view="true"
                                                            @delete="confirmRemoveDetail($event, detail)"
                                                            @edit="selectDetail($event, detail)"
                                                            :has_delete="canRemoveStock" :has_edit="canRemoveStock"
                                                            @view="openSingleProduct(detail.stock.product)" />
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </template>
                                    <template v-slot:action-button>
                                        <button @click="openAddLoadSheetModal()"
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
                <div v-if="loadsheet.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="loadsheet.meta.from" :to="loadsheet.meta.to" :total="loadsheet.meta.total"
                        :next_page_url="loadsheet.links.next" :prev_page_url="loadsheet.links.prev" />
                </div>

            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="history">

                <ol class="relative border-l border-gray-200 dark:border-gray-700 m-2">
                    <li class="mb-10 ml-6" v-for="item in loadsheet.data.history">
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
                                :class="getStatusBackGroundColor(loadsheet.status)"
                                class="bg-blue-100 text-blue-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300 ml-3">{{
                                    item.status }}</span>
                        </h3>
                        <time class="block mb-2 text-sm font-semibold leading-none text-gray-400 dark:text-gray-500">Created
                            On {{ item.created_at }}</time>
                        <p class="mb-4 text-base font-semibold text-gray-500 dark:text-gray-400">
                            Actioned By {{ item.user.first_name }} {{ item.user.last_name }}
                            .</p>
                        <h5 class="flex items-center mb-1 text-lg font-semibold text-gray-900 dark:text-white"
                            v-if="item.status == 'Updated' && getLoadsheetChangedFromDescription(item.description).length > 0">
                            Changes
                        </h5>
                        <div class="relative overflow-x-auto"
                            v-if="item.status == 'Updated' && getLoadsheetChangedFromDescription(item.description).length > 0">
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
                                    <tr v-for="(change, index) in getLoadsheetChangedFromDescription(item.description)"
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
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="customers">
                <button type="button" @click="exportLoadSheetCustomers()"
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
                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="loadsheet.data?.customer_stops.length > 0 ? true : false">
                                    <template v-slot:table>
                                        <table class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
                                            <thead class="bg-gray-100 dark:bg-gray-700">
                                                <tr>
                                                    <!-- <th scope="col" class="p-4">
                                                        <div class="flex items-center">
                                                            <input id="checkbox-all" aria-describedby="checkbox-1"
                                                                type="checkbox"
                                                                class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                            <label for="checkbox-all" class="sr-only">checkbox</label>
                                                        </div>
                                                    </th> -->

                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Name
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Email
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Phone Number
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Address
                                                    </th>


                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                    v-for="customer in loadsheet.data?.customer_stops">
                                                    <!-- <td class="w-4 p-4">
                                                        <div class="flex items-center">
                                                            <input :id="`checkbox-${customer.id}`"
                                                                aria-describedby="checkbox-1" type="checkbox"
                                                                class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                            <label :for="`checkbox-${customer.id}`"
                                                                class="sr-only">checkbox</label>
                                                        </div>
                                                    </td> -->


                                                    <td
                                                        class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                        {{ customer.customer.name }}</td>
                                                    <td
                                                        class="flex p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        <span
                                                            class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                            {{ customer.customer.email }}

                                                        </span>
                                                        <CopyButton @click="copyToClipboard(customer.customer.email)" />
                                                    </td>
                                                    <td
                                                        class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                        <div class="flex">
                                                            <span
                                                                class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                                {{ customer.customer.phone_number }}

                                                            </span>
                                                            <CopyButton @click="copyToClipboard(customer.phone_number)" />
                                                        </div>
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ customer.customer.address }}</td>


                                                    <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <button type="button" @click="openDeleteCustomerStopModal(customer)"
                                                            class=" items-center p-2 text-sm font-medium text-center text-white bg-red-600 rounded-lg hover:bg-red-800 focus:ring-4 focus:ring-red-300 dark:focus:ring-red-900">
                                                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                                                                xmlns="http://www.w3.org/2000/svg">
                                                                <path fill-rule="evenodd"
                                                                    d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                                                    clip-rule="evenodd"></path>
                                                            </svg>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </template>
                                    <template v-slot:action-button>
                                        <button @click="openAddCustomerStopModal()"
                                            class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>

                                            <span>Add Customer Stops</span>
                                        </button>
                                    </template>
                                </TableLayout>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="summary">
                <button type="button" @click="exportLoadSheetSummary()"
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
                <button type="button" @click="downLoadSheetSummary()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">
                    <!-- <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg> -->
                    <i class="bi bi-download w-5 h-5 mr-2 -ml-1"></i>
                    Download Excel
                </button>
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
                                                        {{ detail.total_sale_qty }}{{ detail.product.unit_measure.name }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.total_inload_qty }}{{ detail.product.unit_measure.name }}
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
                                                                {{ detail.order_number }}

                                                            </span>
                                                            <CopyButton @click="copyToClipboard(detail.order_number)" />
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
                <!-- <div v-if="deliverySheet.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="deliverySheet.meta.from" :to="deliverySheet.meta.to"
                        :total="deliverySheet.meta.total" :next_page_url="deliverySheet.links.next"
                        :prev_page_url="deliverySheet.links.prev" />
                </div> -->

            </div>
        </div>
        <AddDetailsLoadSheet @save="closeAddStockModal" @close="closeAddStockModal" :loadsheet="loadsheet.data" />
        <UpdateAddStockDetailStock @save="closeUpdateStockModal" @close="closeUpdateStockModal" :loadsheet="loadsheet.data"
            :detail="selectedDetail" />
        <ConfirmDeleteDialog @yes="deleteDetail" :type="'loadsheet'" @cancel="closeDeleteModal" />
        <ConfirmDeleteDialog @yes="removeCustomerStop" :type="'customer'" @cancel="closeDeleteModal" />
        <AddLoadSheetModal :settings="settings" :loadsheet="loadsheet.data" :trucks="trucks" :warehouses="warehouses"
            :routes="routes" :users="users" @save="closeEditSheet()" />
        <ConfirmLoadSheetModal :loadsheet="loadsheet.data" @save="closeConfirmSheetModal()" @yes="confirmLoadSheet()"
            :type="confirmType" @close="closeConfirmSheetModal()" />

        <AddCustomerStopModal :loadsheet="loadsheet.data" @save="closeAddCustomerStopModal()" :type="confirmType"
            @close="closeAddCustomerStopModal()" />
    </MainLayout>
</template>

<style scoped>
.activeTab {
    border-bottom: 4px solid #2563EB;
}
</style>
