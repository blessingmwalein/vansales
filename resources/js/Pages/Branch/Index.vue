<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddBranchModal from '@/Components/Branch/AddBranchModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
import Multiselect from 'vue-multiselect'
import { Link } from '@inertiajs/vue3';
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';

export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddBranchModal,
        MainLayout,
        CopyButton,
        TableLayout,
        Multiselect,
        Link,
        UserCircleAvartar

    },
    mixins: [globalMixin],

    props: ['branches', 'users', 'warehouses'],
    data() {
        return {
            selectedBranch: null,
            addCustomerModal: null,
            deleteModal: null,
            search: '',
            branches_data: this.branches,
            showSearchForm: true,
            routeOptions: [],
            isLoading: false,
            searchForm: {
                name: '',
                address: '',
                phone_number: null,
                email: '',
                date_range: null,
            }
        }
    },
    mounted() {

        const $targetEl = document.getElementById('add-branch-modal');
        this.addCustomerModal = new Modal($targetEl);

        const $deleteModalEl = document.getElementById('delete-branch-modal');
        this.deleteModal = new Modal($deleteModalEl);

    },


    methods: {
        navigateSingleBranch(branch){
            this.$inertia.visit(`/company/branches/${branch.id}`)
        },
        openAddBranchModal() {
            this.selectedBranch = null;
            this.addCustomerModal.show();
        },

        closeAddBranchModal() {
            this.addCustomerModal.hide();
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },

        deleteBranch() {
            this.$inertia.delete(`/company/branches/${this.selectedBranch.id}`, {
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
        selectCustomer(event, branch) {
            this.selectedBranch = branch;
            this.addCustomerModal.show();
        },
        confirmDeleteDialog(event, branch) {
            this.selectedBranch = branch;
            this.deleteModal.show();
        },
        submitSearch() {
            this.isLoading = true;
            axios.post(`/company/branches-search`, {
                name: this.searchForm.name,
                routes: this.searchForm.routes ? this.searchForm.routes.map(route => route.id) : [],
                phone_number: this.searchForm.phone_number,
                email: this.searchForm.email,
                from: this.searchForm.date_range ? this.searchForm.date_range[0] : null,
                to: this.searchForm.date_range ? this.searchForm.date_range[1] : null,
            })
                .then((response) => {
                    console.log(response);
                    this.branches_data = response.data;
                    this.isLoading = false;
                })
                .catch((error) => {
                    console.log(error);
                    this.isLoading = false;
                });
        },

    },

    watch: {
        branches: {
            handler(newValue) {
                this.branches_data = newValue;
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
                    <BreadCrumb :title="'Branches'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Branches</h1>
                </div>
                <div class="sm:flex">
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">

                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="showSearchForm = !showSearchForm"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-4 focus:ring-green-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                            <i class=" w-5 h-5 mr-2 -ml-1"
                                :class="{ 'bi bi-dash-lg': showSearchForm, 'bi bi-plus-lg': !showSearchForm }"></i>
                            Hide Search Form
                        </button>
                        <button type="button" @click="openAddBranchModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Add Branch
                        </button>

                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">
                    <div class="grid gap-6 sm:grid-cols-4 sm:gap-6 m-4" v-if="showSearchForm">



                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Address</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.address"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone Number</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.phone_number"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div class="">
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div class="">
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.email"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>

                        <div></div>
                        <div></div>

                        <div class="w-full">

                            <button type="button" @click="submitSearch()"
                                class="w-full mt-7 inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                <i class="bi bi-search w-5 h-5 mr-2 -ml-1"></i>

                                Search
                            </button>

                        </div>
                    </div>

                    <div class="overflow-hidden shadow">
                        <TableLayout :hasData="branches_data.data.length > 0 ? true : false" :isLoading="isLoading">
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
                                                Location
                                            </th>


                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                            v-for="branch in branches_data.data">
                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input :id="`checkbox-${branch.id}`" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label :for="`checkbox-${branch.id}`" class="sr-only">checkbox</label>
                                                </div>
                                            </td>


                                            <td
                                                class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                {{ branch.name }}</td>
                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">
                                                <UserCircleAvartar
                                                    :name="`${branch?.user?.first_name} ${branch?.user?.last_name}`" />

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">{{
                                                        branch?.user?.first_name + ' ' + branch?.user?.last_name }}
                                                    </div>
                                                    <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                                        branch.email
                                                    }}
                                                    </div>
                                                </div>
                                            </td>
                                            <td
                                                class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">

                                                <div class="flex">
                                                    <span
                                                        class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                                        {{ branch.phone_number }}

                                                    </span>
                                                    <CopyButton @click="copyToClipboard(branch.phone_number)" />
                                                </div>
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                {{ branch.address }}

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">

                                                    <div class="text-sm font-normal text-gray-500 dark:text-gray-400"> Warehouse: {{ branch?.warehouse?.name }}
                                                    </div>
                                                </div>
                                            </td>


                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'branch'" :has_view="true"
                                                    @delete="confirmDeleteDialog($event, branch)"
                                                    @view="navigateSingleBranch(branch)"
                                                    @edit="selectCustomer($event, branch)" />
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </template>
                            <template v-slot:action-button>
                                <button @click="openAddBranchModal()"
                                    class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>

                                    <span>Add Branch</span>
                                </button>
                            </template>
                        </TableLayout>

                    </div>
                </div>
            </div>
        </div>
        <div v-if="branches_data.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="branches_data.from" :to="branches_data.to" :total="branches_data.total"
                :next_page_url="branches_data.next_page_url" :prev_page_url="branches_data.prev_page_url" />
        </div>

        <AddBranchModal :users="users" :warehouses="warehouses" :branch="selectedBranch" @save="closeAddBranchModal()" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteBranch" :type="'branch'" />
    </MainLayout>
</template>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
