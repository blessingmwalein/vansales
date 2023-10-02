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

import TableLayout from '@/Components/TableLayout.vue';
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
        ConfirmLoadSheetModal

    },
    mixins: [globalMixin],

    props: ['loadsheet', 'details', 'trucks', 'warehouses', 'routes', 'users', 'allDrivers', 'allTrucks'],
    data() {
        return {
            selectedDetail: null,
            addLoadSheetDetail: null,
            updateLoadSheetDetailModal: null,
            confirmLoadSheetModal: null,
            editSheetModal: null,
            deleteModal: null,
            activeTab: 'details',
            selectedDetail: null,
            isShowLoadSheet: false,
            isShowEditSheet: false,
            isShowConfirmSheet: false,
            isShowCancelSheet: false,
            isShowCompleteSheet: false,
            canRemoveStock: true,
            confirmType: 'confirm'
        }
    },
    mounted() {
        this.showLoadSheet();
        this.showEditSheet();
        this.showConfirmSheet();
        this.showCancelSheet();
        this.showCompleteSheet()
        // this.setCanRemoveStock()
        const $targetEl = document.getElementById('add-details-loadsheet-modal');
        this.addLoadSheetDetail = new Modal($targetEl);

        const $targetElConfirm = document.getElementById('confirm-loadsheet-modal');
        this.confirmLoadSheetModal = new Modal($targetElConfirm);

        const $targetElEdit = document.getElementById('add-loadsheet-modal');
        this.editSheetModal = new Modal($targetElEdit);

        const $targetElStock = document.getElementById('update-add-detail-stock');
        this.updateLoadSheetDetailModal = new Modal($targetElStock);

        const $deleteModalEl = document.getElementById('delete-loadsheet-modal');
        this.deleteModal = new Modal($deleteModalEl);


        console.log(this.getLoadsheetChangedFromDescription('Loadsheet Updated fields Changes:{"user_id":8,"truck_id":6,"updated_at":"2023-10-01 22:18:59"}'))
    },
    filters: {
        formatField(value) {
            // Split the string at underscores, capitalize each word, and join with spaces
            return value.split('_').map(word => word.toUpperCase()).join(' ');
        }
    },

    methods: {
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
            this.$inertia.visit(`/admin/products/${product.id}`)
        },
        toggleTab(id) {
            this.activeTab = id;
            if (id == 'details') {
                document.getElementById('details').classList.remove('hidden');
                document.getElementById('history').classList.add('hidden');
            } else {
                document.getElementById('details').classList.add('hidden');
                document.getElementById('history').classList.remove('hidden');
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
            if (this.loadsheet.data.status == 'Confirmed') {
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
            this.$inertia.post(`/admin/delete-loadsheet-detail`,
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

        confirmLoadSheet() {
            if (this.confirmType == 'confirm') {
                this.$inertia.post(`/admin/confirm-loadsheet`,
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
                this.$inertia.post(`/admin/complete-loadsheet`,
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

                    <div class="flex items-start space-x-4">
                        <div class="flex-shrink-0">

                            <span :class="getStatusBackGroundColor(loadsheet.data.status)"
                                class="mb-4 w-20 text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                {{ loadsheet.data.status }}
                            </span>
                            <span
                                class="flex bg-green-200 mb-4 mt-4 text-black text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                Created {{ loadsheet.data.created_at }}
                            </span>
                            <span
                                class="flex bg-green-200 mb-4 text-black text-sm font-semibold mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                Depart Date: {{ loadsheet.data.start_date_time }}
                            </span>

                        </div>
                        <div class="flex-1 min-w-0">
                            <!-- <p class="text-base font-semibold text-gray-900 truncate dark:text-white">
                                {{ loadsheet.data.name }}
                            </p> -->
                            <div class="flex">
                                <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Number: {{
                                    loadsheet.data.loadsheet_number }}</h1>
                                <CopyButton @click="copyToClipboard(loadsheet.data.loadsheet_number)" />

                            </div>

                            <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                Driver: {{ loadsheet.data.user.first_name }} {{ loadsheet.data.user.last_name }}
                            </p>
                            <div class="flex mt-1">

                                <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                    Phone Number: {{ loadsheet.data.user.phone_number }}
                                </p>
                                <CopyButton @click="copyToClipboard(`${loadsheet.data.route.start_lat} ${loadsheet.data.route.start_lon}
                                   `)" />
                            </div>
                            <div class="flex mt-1">
                                <p class="text-base font-semibold text-gray-600 truncate dark:text-gray-400">
                                    Email: {{ loadsheet.data.user.email }}
                                </p>
                                <CopyButton @click="copyToClipboard(`${loadsheet.data.route.start_lat} ${loadsheet.data.route.start_lon}
                                   `)" />
                            </div>
                        </div>
                        <div class="flex-1 min-w-0">
                            <!-- <p class="text-base font-semibold text-gray-900 truncate dark:text-white">
                                {{ loadsheet.data.name }}
                            </p> -->
                            <div class="flex">
                                <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white"> {{
                                    loadsheet.data.truck.make_model }}</h1>
                            </div>

                            <div class="flex">
                                <span
                                    class="flex bg-yellow-400 text-white border-2 border-black	 font-medium mr-2 px-3 py-1 rounded dark:bg-blue-900 dark:text-blue-300 ">
                                    {{ loadsheet.data.truck.license_plate
                                    }}

                                </span>
                                <CopyButton @click="copyToClipboard(loadsheet.data.loadsheet_number)" />
                            </div>
                            <p class="mt-1 text-base font-semibold text-gray-500 truncate dark:text-gray-400">
                                Mileage: {{ loadsheet.data.truck.start_mileage }}km
                            </p>
                            <p class="mt-1 text-base font-semibold text-gray-500 truncate dark:text-gray-400">
                                Color: {{ loadsheet.data.truck.color }}
                            </p>
                        </div>
                        <div class="flex-1 min-w-0">
                            <!-- <p class="text-base font-semibold text-gray-900 truncate dark:text-white">
                                {{ loadsheet.data.name }}
                            </p> -->
                            <div class="flex">
                                <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white"> {{
                                    loadsheet.data.route.name }} route</h1>
                            </div>

                            <div class="flex">
                                <span
                                    class="flex bg-purple-400 text-white text-sm mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                    Lat: {{ loadsheet.data.route.start_lat
                                    }} -Lng:
                                    {{ loadsheet.data.route.start_lon
                                    }}

                                </span>
                                <CopyButton @click="copyToClipboard(`${loadsheet.data.route.start_lat} ${loadsheet.data.route.start_lon}
                                   `)" />
                            </div>

                            <div class="flex">

                                <p class="mt-1 text-base font-semibold text-gray-500 truncate dark:text-gray-400">
                                    Warehouse: {{ loadsheet.data.warehouse.name }}
                                </p>
                            </div>

                            <div class="flex mt-1">
                                <span
                                    class="flex bg-blue-400 text-white text-sm mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                    {{ loadsheet.data.warehouse.code
                                    }}

                                </span>
                                <CopyButton @click="copyToClipboard(`${loadsheet.data.route.start_lat} ${loadsheet.data.route.start_lon}
                                   `)" />
                            </div>


                        </div>


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
                        :class="{ 'activeTab': activeTab == 'details' }" @click="toggleTab('details')">Loadsheet
                        Items</button>
                </li>
                <li class="mr-2">
                    <button @click="toggleTab('history')" :class="{ 'activeTab': activeTab == 'history' }"
                        class="inline-block p-4 text-base font-semibold border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button">Loadsheet History</button>
                </li>

            </ul>
        </div>
        <div>
            <div class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="details">

                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="details.length > 0 ? true : false">
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
                                                    v-for="detail in details">

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
                                                        ${{ detail.stock.product.retail_unit_price }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        ${{ detail.stock.product.wholesale_unit_price }}
                                                    </td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ detail.stock.product.discount }}%
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
                                        <button @click="openAddProductModal()"
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
        </div>
        <AddDetailsLoadSheet @save="closeAddStockModal" @close="closeAddStockModal" :loadsheet="loadsheet.data" />
        <UpdateAddStockDetailStock @save="closeUpdateStockModal" @close="closeUpdateStockModal" :loadsheet="loadsheet.data"
            :detail="selectedDetail" />
        <ConfirmDeleteDialog @yes="deleteDetail" :type="'loadsheet'" @cancel="closeDeleteModal" />
        <AddLoadSheetModal :loadsheet="loadsheet.data" :trucks="trucks" :warehouses="warehouses" :categories="categories"
            :routes="routes" :users="users" @save="closeEditSheet()" />
        <ConfirmLoadSheetModal :loadsheet="loadsheet.data" @save="closeConfirmSheetModal()" @yes="confirmLoadSheet()"
            :type="confirmType" @close="closeConfirmSheetModal()" />
    </MainLayout>
</template>

<style scoped>
.activeTab {
    border-bottom: 4px solid #2563EB;
}
</style>
