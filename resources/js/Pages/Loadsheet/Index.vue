<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddLoadSheetModal from '@/Components/Loadsheet/AddLoadSheetModal.vue';
import UploadExcelProductsModal from '@/Components/Warehouse/UploadExcelProductsModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
import Multiselect from 'vue-multiselect'
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

export default {
    mixins: [globalMixin],

    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddLoadSheetModal,
        MainLayout,
        CopyButton,
        UploadExcelProductsModal,
        TableLayout,
        Multiselect,
        Datepicker
    },

    props: ['loadsheets', 'trucks', 'warehouses', 'routes', 'users', 'allDrivers', 'allTrucks', 'settings'],
    data() {
        return {
            selectedLoadSheet: null,
            addLoadSheetModal: null,
            uploadExcelProductModal: null,
            deleteModal: null,
            loadsheets_data: this.loadsheets,
            search: '',
            selectedStatus: null,
            statusOptions: [
                { id: 1, name: 'Draft' },
                { id: 2, name: 'Created' },
                { id: 3, name: 'Cancelled' },
                { id: 4, name: 'Confirmed' },
                { id: 5, name: 'Loaded' },
                { id: 6, name: 'Completed' },
            ],
            isLoading: false,
            userOptions: [],
            truckOptions: [],
            warehouseOptions: [],
            routeOptions: [],
            showSearchForm: true,
            searchForm: {
                user: '',
                truck: '',
                warehouse: '',
                route: '',
                date_range: '',
                status: '',
            },
        }
    },
    mounted() {
        this.updateOptions()

        const $targetEl = document.getElementById('add-loadsheet-modal');
        this.addLoadSheetModal = new Modal($targetEl);

        const $targetElUpload = document.getElementById('upload-excel-loadsheet');
        this.uploadExcelProductModal = new Modal($targetElUpload);

        const $deleteModalEl = document.getElementById('delete-loadsheet-modal');
        this.deleteModal = new Modal($deleteModalEl);

    },


    methods: {
        updateOptions() {
            this.userOptions = this.allDrivers.map(user => {
                return {
                    id: user.id,
                    first: user.first_name,
                    second: user.last_name,
                }
            })

            this.truckOptions = this.allTrucks.map(truck => {
                return {
                    id: truck.id,
                    first: truck.make_model,
                    second: truck.license_plate,
                }
            })

            this.warehouseOptions = this.warehouses.map(warehouse => {
                return {
                    id: warehouse.id,
                    first: warehouse.code,
                    second: warehouse.name,
                }
            })

            this.routeOptions = this.routes.map(route => {
                return {
                    id: route.id,
                    first: route.name,
                    second: '',
                }
            })
        },
        openAddLoadSheetModal() {
            this.selectedLoadSheet = null;
            this.addLoadSheetModal.show();
        },

        closeAddLoadSheetModal() {
            this.addLoadSheetModal.hide();
        },

        closeDeleteModal() {
            this.deleteModal.hide();
        },

        deleteLoadsheet() {
            this.$inertia.delete(`/admin/loadsheets/${this.selectedLoadSheet.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.closeDeleteModal();
                }
            });
        },

        selectLoadSheet(event, loadsheet) {
            this.selectedLoadSheet = loadsheet;
            this.addLoadSheetModal.show();
        },
        confirmDeleteDialog(event, loadsheet) {
            this.selectedLoadSheet = loadsheet;
            this.deleteModal.show();
        },
        openSingleProduct(loadsheet) {
            this.$inertia.visit(`/admin/loadsheets/${loadsheet.id}`)
        },


        submitSearch() {
            this.isLoading = true;
            axios.post(`/admin/filter-loadsheets`, {
                'driver': this.searchForm.user ? this.searchForm.user.map(obj => obj.id) : [],
                'truck': this.searchForm.truck ? this.searchForm.truck.map(obj => obj.id) : [],
                'warehouse': this.searchForm.warehouse ? this.searchForm.warehouse.map(obj => obj.id) : [],
                'route': this.searchForm.route ? this.searchForm.route.map(obj => obj.id) : '',
                'status': this.searchForm.status ? this.searchForm.status.map(obj => obj.name) : [],
                'from': this.searchForm.date_range ? this.searchForm.date_range[0] : '',
                'to': this.searchForm.date_range ? this.searchForm.date_range[1] : '',
            })
                .then((response) => {
                    console.log(response);
                    this.loadsheets_data = response.data;
                    this.isLoading = false;
                })
                .catch((error) => {
                    console.log(error);
                    this.isLoading = false;
                });
        },

        reset() {
            this.searchForm = {
                user: '',
                truck: '',
                warehouse: '',
                route: '',
                date_range: '',
                status: '',
            }
            this.submitSearch();
        },
        returnFormatedName({ first, second }) {
            return `${first} — ${second}`
        },
        getStatusBackGroundColor(status) {
            //switch case
            switch (status) {
                case 'Draft':
                    return 'bg-yellow-300 text-yellow-800';
                    break;
                case 'Created':
                    return 'bg-green-500 text-white';
                    break;
                case 'Cancelled':
                    return 'bg-red-500 text-white';
                    break;
                case 'Confirmed':
                    return 'bg-blue-500 text-white';
                    break;
                case 'Loaded':
                    return 'bg-gray-500 text-white';
                    break;
                default:
                    return 'bg-gray-500 text-white';
                    break;
            }
        },
    },

    watch: {
        loadsheets: {
            handler(newValue) {
                this.loadsheets_data = newValue;
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
                    <BreadCrumb :title="'LoadSheets'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Loadsheets</h1>
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <span
                            class="bg-purple-500 text-white text-medium font-medium mr-2 px-3 py-1 rounded dark:bg-purple-900 dark:text-purple-300">
                            {{ loadsheets_data.meta.total }} records found</span>
                    </div>

                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="showSearchForm = !showSearchForm"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-4 focus:ring-green-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                            <i class=" w-5 h-5 mr-2 -ml-1"
                                :class="{ 'bi bi-dash-lg': showSearchForm, 'bi bi-plus-lg': !showSearchForm }"></i>
                            Hide Search Form
                        </button>
                        <button type="button" @click="reset()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-purple-700 hover:bg-purple-800 focus:outline-none focus:ring-4 focus:ring-purple-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                            <i class="bi bi-arrow-clockwise w-5 h-5 mr-2 -ml-1"></i>
                            Reset
                        </button>
                        <button type="button" @click="downloadExcel()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-yellow-400 hover:bg-yellow-500 focus:ring-4 focus:ring-yellow-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">
                            <!-- <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg> -->
                            <i class="bi bi-file-earmark-excel w-5 h-5 mr-2 -ml-1"></i>
                            Export Excel
                        </button>
                        <button type="button" @click="openAddLoadSheetModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Create LoadSheet
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
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Status</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="searchForm.status" :options="statusOptions" :multiple="true"
                                placeholder="Filter by status" label="name" track-by="id">
                            </multiselect>
                        </div>
                        <div class="w-full">
                            <label for="price"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Driver</label>
                            <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                :multiple="true" v-model="searchForm.user" :options="userOptions"
                                :custom-label="returnFormatedName" placeholder="Driver" label="name" track-by="id">
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
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Truck</label>
                            <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                :multiple="true" v-model="searchForm.truck" :options="truckOptions"
                                :custom-label="returnFormatedName" placeholder="Truck" label="name" track-by="id">
                            </multiselect>
                        </div>
                        <div class="">
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Route</label>
                            <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                :multiple="true" v-model="searchForm.route" :options="routeOptions"
                                :custom-label="returnFormatedName" placeholder="Route" label="name" track-by="id">
                            </multiselect>
                        </div>
                        <div class="">
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Warehouse</label>
                            <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                v-model="searchForm.warehouse" :options="warehouseOptions" :multiple="true"
                                :custom-label="returnFormatedName" placeholder="Warehouse" label="name" track-by="id">
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
                        <TableLayout :isLoading="isLoading" :hasData="loadsheets_data.data.length > 0 ? true : false">
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
                                                Details
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Truck
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Warehouse
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Route
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Status
                                            </th>


                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Delivery Date
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                            v-for="loadsheet in loadsheets_data.data">
                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input id="checkbox-194556" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label for="checkbox-194556" class="sr-only">checkbox</label>
                                                </div>
                                            </td>
                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">



                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">
                                                        Driver: {{ loadsheet.user.first_name }} {{ loadsheet.user.last_name
                                                        }}</div>

                                                    <div
                                                        class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span
                                                            class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                            {{ loadsheet.loadsheet_number }}

                                                        </span>
                                                        <CopyButton @click="copyToClipboard(loadsheet.loadsheet_number)" />
                                                    </div>
                                                </div>
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <div class="flex-coulumn">
                                                    <h1 class="text-base font-semibold">
                                                        {{ loadsheet.truck.make_model }}</h1>

                                                    <div
                                                        class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                        <span class="text-xs font-medium text-gray-500">
                                                            {{ loadsheet.truck.license_plate }}
                                                        </span>

                                                        <CopyButton @click="copyToClipboard(loadsheet.loadsheet_number)" />
                                                    </div>


                                                </div>
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <h1 class="text-base font-semibold">
                                                    {{ loadsheet.warehouse.name }}</h1>

                                                <div class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <span class="text-xs font-medium text-gray-500">
                                                        {{ loadsheet.warehouse.code }}
                                                    </span>

                                                    <CopyButton @click="copyToClipboard(loadsheet.warehouse.code)" />
                                                </div>
                                            </td>
                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ loadsheet.route.name }}
                                                <div class="mt-1 flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <span class="text-xs font-medium text-gray-500">
                                                        Centers: {{ loadsheet.route.number_centers }}
                                                    </span>

                                                </div>
                                            </td>
                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <span :class="getStatusBackGroundColor(loadsheet.status)"
                                                    class="bg-green-500 text-xs font-medium mr-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300">
                                                    {{ loadsheet.status }}
                                                </span>
                                            </td>

                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ loadsheet.start_date_time }}
                                            </td>

                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'loadsheet'" :has_view="true"
                                                    @delete="confirmDeleteDialog($event, loadsheet)"
                                                    @edit="selectLoadSheet($event, loadsheet)"
                                                    @view="openSingleProduct(loadsheet)" />
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

                                    <span>Create Loadsheet</span>
                                </button>
                            </template>
                        </TableLayout>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="loadsheets_data.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="loadsheets_data.meta.from" :to="loadsheets_data.meta.to" :total="loadsheets_data.meta.total"
                :next_page_url="loadsheets_data.links.next" :prev_page_url="loadsheets_data.links.prev" />
        </div>

        <AddLoadSheetModal :settings="settings" :loadsheet="selectedLoadSheet" :trucks="trucks" :warehouses="warehouses"
            :routes="routes" :users="users" @save="closeAddLoadSheetModal()" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteLoadsheet" :type="'loadsheet'" />
    </MainLayout>
</template>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
