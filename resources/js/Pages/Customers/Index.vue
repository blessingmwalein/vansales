<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddCustomerModal from '@/Components/Customer/AddCustomerModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddCustomerModal,
        MainLayout,
        CopyButton,
        TableLayout
    },
    mixins: [globalMixin],

    props: ['customers'],
    data() {
        return {
            selectedCustomer: null,
            addCustomerModal: null,
            deleteModal: null,
            search: '',
            customers_data: this.customers

        }
    },
    mounted() {
        const $targetEl = document.getElementById('add-customer-modal');
        this.addCustomerModal = new Modal($targetEl);

        const $deleteModalEl = document.getElementById('delete-customer-modal');
        this.deleteModal = new Modal($deleteModalEl);

    },


    methods: {
        openAddCustomerModal() {
            this.selectedCustomer = null;
            this.addCustomerModal.show();
        },

        closeAddCustomerModal() {
            this.addCustomerModal.hide();
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },

        deleteCustomer() {
            this.$inertia.delete(`/admin/customers/${this.selectedCustomer.id}`, {
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
        selectCustomer(event, customer) {
            this.selectedCustomer = customer;
            this.addCustomerModal.show();
        },
        confirmDeleteDialog(event, customer) {
            this.selectedCustomer = customer;
            this.deleteModal.show();
        },
        submitSearch() {
            // this.$inertia.post(`/admin/products-search`, {
            //     search: this.search
            // },
            //     {
            //         preserveScroll: true,
            //         onSuccess: (page) => {
            //             // console.log(page);
            //             this.products_data = page;
            //         }
            //     });
            //use axios
            axios.post(`/admin/customers-search`, {
                search: this.search
            })
                .then((response) => {
                    console.log(response);
                    this.customers = response.data;
                })
                .catch((error) => {
                    console.log(error);
                });
        },

    },

    watch: {
        customers: {
            handler(newValue) {
                this.customers_data = newValue;
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
                    <BreadCrumb :title="'Stock/Trucks'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Trucks</h1>
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <form class="lg:pr-3" action="#" method="GET">
                            <label for="users-search" class="sr-only">Search</label>
                            <div class="relative mt-1 lg:w-64 xl:w-96">
                                <input type="text" name="email" id="users-search" v-model="search"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                    placeholder="Search for customers by name, email or phone number">
                            </div>
                        </form>
                        <div class="flex pl-0 mt-3 space-x-1 sm:pl-2 sm:mt-0">
                            <button type="button" @click="submitSearch()"
                                class="inline-flex p-2 items-center text-sm font-medium text-center text-white text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                <svg class="w-6 h-6 " aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                                    viewBox="0 0 20 20">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2" d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z" />
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="openAddCustomerModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Add Customer
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="overflow-hidden shadow">
                        <TableLayout :hasData="customers_data.data.length > 0 ? true : false">
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
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                            v-for="customer in customers_data.data">
                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input :id="`checkbox-${customer.id}`" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label :for="`checkbox-${customer.id}`" class="sr-only">checkbox</label>
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
                                                <TableActionButtons :type="'customer'" :has_view="false"
                                                    @delete="confirmDeleteDialog($event, customer)"
                                                    @edit="selectCustomer($event, customer)" />
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </template>
                            <template v-slot:action-button>
                                <button @click="openAddCustomerModal()"
                                    class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>

                                    <span>Add Customer</span>
                                </button>
                            </template>
                        </TableLayout>

                    </div>
                </div>
            </div>
        </div>
        <div v-if="customers_data.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="customers_data.from" :to="customers_data.to" :total="customers_data.total"
                :next_page_url="customers_data.next_page_url" :prev_page_url="customers_data.prev_page_url" />
        </div>

        <AddCustomerModal :customer="selectedCustomer" @save="closeAddCustomerModal()" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteCustomer" :type="'customer'" />
    </MainLayout>
</template>
