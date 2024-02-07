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
import CustomerInfoMapWindow from '@/Components/Customer/CustomerInfoMapWindow.vue';

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
        CustomerInfoMapWindow
    },
    mixins: [globalMixin],

    props: ['customers'],
    data() {
        return {
            openedMarkerID: null,
            center: { lat: -17.8292, lng: 31.054 },
            paths: [

            ],
            markers: [

            ],
        }
    },
    mounted() {
        this.setPath();
    },


    methods: {
        openInfoWindow(id) {
            this.openedMarkerID = id
        },
        openMarker(id) {
            this.openedMarkerID = id
        },
        setPath() {
            console.log(this.customers)
            this.customers.forEach(customer => {
                this.markers.push({
                    id: customer.id,
                    name: customer.name,
                    address: customer.address,
                    phone_number: customer.phone_number,
                    email: customer.email,
                    route: customer?.route?.name,
                    position: { lat: customer?.lat, lng: customer?.lon },
                });
            })
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
                    <BreadCrumb :title="`Customer Map`" />

                    <div class="flex items-center space-x-4">
                        <div class="flex-1 min-w-0">

                            <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Customer Map</h1>
                        </div>

                    </div>
                    <!-- <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">{{ route.name }}</h1> -->
                </div>

            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="overflow-hidden shadow">
                        <GMapMap :center="center" :zoom="8" style="width: 82vw; height: 82vh">
                            <!-- <GMapPolygon :paths="paths" /> -->
                            <GMapMarker :key="index" v-for="(m, index) in markers" :position="m.position"
                                @click="openInfoWindow(m.id)" :clickable="true" :icon='{
                                    url: "/assets/location.svg",
                                    scaledSize: { width: 50, height: 50 },
                                }'>
                                <GMapInfoWindow :closeclick="true" @closeclick="openMarker(null)"
                                    :opened="openedMarkerID === m.id">
                                    <CustomerInfoMapWindow :customer="m" />
                                </GMapInfoWindow>
                            </GMapMarker>
                        </GMapMap>

                    </div>
                </div>
            </div>
        </div>

        <!-- <AllocateStockModal @save="closeAddStockModal" @close="closeAddStockModal" :route="route" /> -->

    </MainLayout>
</template>
