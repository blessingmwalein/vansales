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
import MapInfoWindow from '@/Components/Route/MapInfoWindow.vue';

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
        MapInfoWindow
    },
    mixins: [globalMixin],

    props: ['route'],
    data() {
        return {
            openedMarkerID: null,
            selectedStock: null,
            addStockModal: null,
            updateStockModal: null,
            deleteModal: null,
            center: { lat: -17.8292, lng: 31.054 },
            paths: [

            ],
            markers: [

            ],
        }
    },
    mounted() {
        this.setPath();
        const $targetEl = document.getElementById('add-stock-modal');
        this.addStockModal = new Modal($targetEl);

        const $targetElStock = document.getElementById('update-allocate-stock');
        this.updateStockModal = new Modal($targetElStock);

        const $deleteModalEl = document.getElementById('delete-stock-modal');
        this.deleteModal = new Modal($deleteModalEl);

    },


    methods: {
        openInfoWindow(id) {
            this.openedMarkerID = id
        },
        openMarker(id) {
            this.openedMarkerID = id
        },
        setPath() {
            this.paths = this.route.nodes.map(node => {
                this.markers.push({
                    id: node.id,
                    name: node.name,
                    position: { lat: node.lat, lng: node.lon },
                });
                return { lat: node.lat, lng: node.lon }
            })
        },
        openAddNodeModal() {
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
                    <BreadCrumb :title="`Stock/${route.name}`" />

                    <div class="flex items-center space-x-4">
                        <img class="h-20 w-20 max-w-lg rounded-lg" :src="`/storage/default.png`" alt="image description">
                        <div class="flex-1 min-w-0">
                            <!-- <p class="text-base font-semibold text-gray-900 truncate dark:text-white">
                                {{ route.name }}
                            </p> -->
                            <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white"> {{ route.name
                            }}</h1>
                            <p class="w-20 text-sm font-normal text-gray-500 truncate dark:text-gray-400">
                                <span
                                    class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                    Centers: {{ route.number_centers }}
                                </span>
                            </p>
                        </div>
                        <div class="inline-flex items-center">
                            <span
                                class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                Lat: {{ route.start_lat }} Lat: {{ route.start_lon }}
                            </span>
                            <CopyButton @click="copyToClipboard(`${route.start_lat} ${route.start_lon}`)" />
                        </div>
                    </div>
                    <!-- <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">{{ route.name }}</h1> -->
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Route Map</h1>

                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="openAddNodeModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Add Node
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="overflow-hidden shadow">
                        <GMapMap :center="center" :zoom="8" style="width: 82vw; height: 82vh">
                            <!-- <GMapPolygon :paths="paths" /> -->

                            <GMapPolyline :path="paths" :editable="true" ref="polyline" />
                            <GMapMarker :key="index" v-for="(m, index) in markers" :position="m.position"
                                @click="openInfoWindow(m.id)" :clickable="true" :icon='{
                                    url: "/assets/location.svg",
                                    scaledSize: { width: 50, height: 50 },
                                }'>
                                <GMapInfoWindow :closeclick="true" @closeclick="openMarker(null)"
                                    :opened="openedMarkerID === m.id">
                                    <MapInfoWindow :node="m" />
                                </GMapInfoWindow>
                            </GMapMarker>
                        </GMapMap>

                    </div>
                </div>
            </div>
        </div>

        <!-- <AllocateStockModal @save="closeAddStockModal" @close="closeAddStockModal" :route="route" /> -->

        <ConfirmDeleteDialog :type="'stock'" @cancel="closeDeleteModal" />
    </MainLayout>
</template>
