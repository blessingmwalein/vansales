<template>
    <div id="view-delivery-modal" tabindex="-1"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-4xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-5 border-b rounded-t dark:border-gray-600">
                    <!-- <h3 class="text-xl font-medium text-gray-900 dark:text-white">
                        View Delivery {{ delivery_data?.id }}
                    </h3> -->
                    <div class="flex items-center mr-12 space-x-6 whitespace-nowrap" v-if="delivery_data">
                        <UserCircleAvartar :name="`${delivery_data.customer.name}`" />

                        <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                            <div class="text-base font-semibold text-gray-900 dark:text-white">
                                {{
                                    delivery_data.customer.name }}
                            </div>
                            <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                {{
                                    delivery_data.customer.email
                                }}
                            </div>
                        </div>
                    </div>
                    <button @click="$emit('close')" type="button"
                        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-6 space-y-6">
                    <TableLayout :hasData="delivery_data?.items.length > 0 ? true : false">
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
                                            Allocated Quantity
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
                                <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                    <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                        v-for="detail in delivery_data.items">

                                        <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">


                                            <img class="h-10 w-10 max-w-lg rounded-lg"
                                                :src="`/storage/${detail.product.image}`" alt="image description">

                                            <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                <div class="text-base font-semibold text-gray-900 dark:text-white">
                                                    {{ detail.product.description }}</div>

                                                <div class="flex text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <span
                                                        class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                        {{ detail.product.code }}

                                                    </span>
                                                    <CopyButton @click="copyToClipboard(detail.product.code)" />
                                                </div>
                                            </div>
                                        </td>


                                        <td
                                            class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            {{ detail.quantity }} {{ detail.unit.name }}
                                        </td>
                                        <td
                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            {{ detail.defaultPrice?.currency?.symbol }}{{
                                                detail.defaultPrice.retail_price }}
                                        </td>
                                        <td
                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            {{ detail.defaultPrice?.currency?.symbol }}{{
                                                detail.defaultPrice.wholesale_price }}
                                        </td>
                                        <td
                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            {{
                                                detail.defaultPrice.discount }}%
                                        </td>

                                        <td class="p-4 space-x-2 whitespace-nowrap">
                                            <TableActionButtons :type="'deliveryItem'"
                                                @delete="confirmRemoveDetail($event, detail)"
                                                @edit="selectDetail($event, detail)" :has_delete="true" :has_edit="true"
                                                :has_view="false" />
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
</template>
<script>
import VueMultiselect from 'vue-multiselect'
import { useForm } from '@inertiajs/vue3';
import InputError from '@/Components/InputError.vue';
import CopyButton from '@/Components/CopyButton.vue';
import TableLayout from '@/Components/TableLayout.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';


export default {
    props: ['delivery'],
    components: {
        VueMultiselect,
        InputError,
        CopyButton,
        TableLayout,
        TableActionButtons,
        UserCircleAvartar
    },
    data() {
        return {
            delivery_data: this.delivery
        }
    },

    methods: {

    },

    watch: {
        // Watch the 'tax' prop for changes
        delivery: {
            handler(newValue) {
                console.log(newValue)
                this.delivery_data = newValue
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}

</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
