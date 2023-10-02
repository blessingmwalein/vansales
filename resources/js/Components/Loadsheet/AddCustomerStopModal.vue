<template>
    <div id="add-customer-stop-modal" tabindex="-1"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-7xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-5 border-b rounded-t dark:border-gray-600">
                    <h3 class="text-xl font-medium text-gray-900 dark:text-white">
                        Add Customer Stops
                    </h3>
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
                    <form class="" action="#">
                        <div>
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Search By name, email,
                                phone</label>
                            <VueMultiselect :searchable="true" :options="options" :custom-label="nameWithEmail"
                                :clearOnSelect="true" @search-change="searchCustomer" @select="selectCustomer">
                            </VueMultiselect>

                        </div>

                    </form>

                    <div class="flex flex-col">
                        <div class="overflow-x-auto">
                            <div class="inline-block min-w-full align-middle">
                                <div class="overflow-hidden shadow">

                                    <table class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
                                        <thead class="bg-gray-100 dark:bg-gray-700">
                                            <tr>
                                                <th scope="col" class="p-4">
                                                    <div class="flex items-center">
                                                        <input id="checkbox-all" aria-describedby="checkbox-1"
                                                            type="checkbox"
                                                            class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                        <label for="checkbox-all" class="sr-only">checkbox</label>
                                                    </div>
                                                </th>

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
                                                v-for="customer in selectedCustomers">
                                                <td class="w-4 p-4">
                                                    <div class="flex items-center">
                                                        <input :id="`checkbox-${customer.id}`" aria-describedby="checkbox-1"
                                                            type="checkbox"
                                                            class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                        <label :for="`checkbox-${customer.id}`"
                                                            class="sr-only">checkbox</label>
                                                    </div>
                                                </td>


                                                <td
                                                    class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                    {{ customer.name }}</td>
                                                <td
                                                    class="flex p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                    <span
                                                        class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                        {{ customer.email }}

                                                    </span>
                                                    <CopyButton @click="copyToClipboard(customer.email)" />
                                                </td>
                                                <td
                                                    class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                    <div class="flex">
                                                        <span
                                                            class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                            {{ customer.phone_number }}

                                                        </span>
                                                        <CopyButton @click="copyToClipboard(customer.phone_number)" />
                                                    </div>
                                                </td>
                                                <td
                                                    class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                    {{ customer.address }}</td>


                                                <td class="p-4 space-x-2 whitespace-nowrap">
                                                    <button type="button" @click="removeCustomer(customer)"
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
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- Modal footer -->
                <div class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600">
                    <button type="button" @click="submit" :class="{ 'opacity-25': form.processing || isFormDirty }"
                        :disabled="form.processing || isFormDirty"
                        class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Add
                        Customers</button>
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

export default {
    props: ['loadsheet'],
    components: {
        VueMultiselect,
        InputError,
        CopyButton
    },
    data() {
        return {
            selectedCustomers: [],
            options: [],
            isFormDirty: false,
            form: useForm({
                loadsheet_id: this.loadsheet?.id || null,
                customer_stops: [],
            })
        }
    },

    methods: {
        searchCustomer(value, loading) {
            axios
                .post(`/admin/customers-search`, {
                    search: value
                })
                .then((response) => {
                    this.options = response.data.map((customer) => {
                        console.log(customer)
                        return {
                            label: `${customer.name} - ${customer.email}`,
                            id: customer.id,
                            customer_id: customer.id,
                            name: customer.name,
                            email: customer.email,
                            phone_number: customer.phone_number,
                            address: customer.address,
                        };
                    });
                })
                .catch((error) => {
                    console.log(error);
                });
        },

        checkIfCustomerExists(customer) {
            return this.selectedCustomers.some((selectedCustomer) => {
                return selectedCustomer.id === customer.id;
            });
        },

        nameWithEmail({
            label
        }) {
            return label;
        },

        selectCustomer(customer) {
            console.log(customer)
            if (this.checkIfCustomerExists(customer)) {
                return;
            }
            this.selectedCustomers.push(
                customer
            );
        },

        removeCustomer(customer) {
            this.selectedCustomers = this.selectedCustomers.filter((selectedCustomer) => {
                return selectedCustomer.id !== customer.id;
            });
        },

        submit() {
            this.form.customer_stops = this.selectedCustomers.map((customer) => {
                return customer.customer_id;
            })

            this.form.post('/admin/add-customer-stops', {
                preserveScroll: true,
                onSuccess: () => {
                    this.selectedCustomers = [];
                    this.options = [];
                    this.$emit('save');
                }
            });
        },

    },

    watch: {
        // Watch the 'tax' prop for changes
        loadsheet: {
            handler(newValue) {
                this.form.loadsheet_id = newValue?.id || null;
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}

</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>