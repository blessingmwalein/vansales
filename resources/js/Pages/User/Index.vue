<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddUserModal from '@/Components/User/AddUserModal.vue';
import ViewRoleModal from '@/Components/User/ViewRoleModal.vue';
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import Multiselect from 'vue-multiselect'


export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddUserModal,
        MainLayout,
        ViewRoleModal,
        UserCircleAvartar,
        TableLayout,
        Multiselect
    },

    props: ['users', 'roles', 'settings', 'warehouses', 'routes', 'trucks'],
    data() {
        return {
            user_data: this.users,
            selectedUser: null,
            addUserModal: null,
            deleteModal: null,
            viewUserModal: null,
            rolesOptions: [],
            showSearchForm: true,
            isLoading: false,
            searchForm: {
                role: null,
                date_range: null,
                first_name: null,
                last_name: null,
                email: null,
                phone_number: null,
            },
        }
    },
    mounted() {
        this.updateOptions();
        const $targetEl = document.getElementById('add-user-modal');
        this.addUserModal = new Modal($targetEl);

        const $deleteModalEl = document.getElementById('delete-user-modal');
        this.deleteModal = new Modal($deleteModalEl);

        const $viewRoleModalEl = document.getElementById('view-user-modal');
        this.viewUserModal = new Modal($viewRoleModalEl);
    },


    methods: {
        updateOptions() {
            this.rolesOptions = this.roles.map(role => {
                return {
                    id: role.id,
                    name: role.name
                }
            });
        },

        returnFormatedName({ name }) {
            return name;
        },
        openAddUserModal() {
            this.selectedUser = null;
            this.addUserModal.show();
        },
        openViewUserModal(user) {
            this.selectedUser = user;
            this.viewUserModal.show();
        },
        closeAddUserModal() {
            this.addUserModal.hide();
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },
        closeViewRoleModal() {
            this.viewUserModal.hide();
        },
        deleteUser() {
            this.$inertia.delete(`/admin/users/${this.selectedUser.id}`, {
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
        selectRole(event, user) {
            this.selectedUser = user;
            this.addUserModal.show();
        },
        confirmDeleteDialog(event, user) {
            this.selectedUser = user;
            this.deleteModal.show();
        },
        submitSearch() {
            this.isLoading = true;

            const { role } = this.searchForm
            axios.post(`/admin/search-users`, {
                role: role ? role.id : null,
                ...this.searchForm
            })
                .then((response) => {
                    console.log(response);
                    this.user_data = response.data;
                    this.isLoading = false;
                })
                .catch((error) => {
                    console.log(error);
                    this.isLoading = false;
                });

        }
    },

    //watchers
    watch: {
        users: function (val) {
            this.user_data = val;
        },

    }


};
</script>

<template>
    <MainLayout>

        <div
            class="p-4 bg-white block sm:flex items-center justify-between border-b border-gray-200 lg:mt-1.5 dark:bg-gray-800 dark:border-gray-700">
            <div class="w-full mb-1">
                <div class="mb-4">
                    <BreadCrumb :title="'Users'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Users</h1>
                </div>
                <div class="sm:flex">

                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="showSearchForm = !showSearchForm"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-4 focus:ring-green-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                            <i class=" w-5 h-5 mr-2 -ml-1"
                                :class="{ 'bi bi-dash-lg': showSearchForm, 'bi bi-plus-lg': !showSearchForm }"></i>
                            Hide Search Form
                        </button>
                        <button type="button"
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
                        <button type="button" @click="openAddUserModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">

                            <i class="bi bi-person-plus-fill w-5 h-5 mr-2 -ml-1"></i>
                            Add User
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
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">First Name</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.first_name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Last Name</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.last_name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.email"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone Number</label>
                            <input type="text" name="email" id="users-search" v-model="searchForm.phone_number"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div class="w-full">
                            <label for="brand"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Role</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="searchForm.role" :options="rolesOptions" :multiple="false" label="name"
                                track-by="id" :custom-label="returnFormatedName">
                            </multiselect>
                        </div>


                        <div>
                            <label for="category" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Date
                                Range</label>
                            <Datepicker placeholder="Date Range"
                                class="z-20 block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="searchForm.date_range" range />
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
                        <TableLayout :hasData="user_data.data.length > 0 ? true : false" :isLoading="isLoading">
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
                                                Phone Number
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Role
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Available
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                More Details
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700" v-for="user in user_data.data">

                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input :id="`checkbox-${user.id}`" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label :for="`checkbox-${user.id}`" class="sr-only">checkbox</label>
                                                </div>
                                            </td>
                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">
                                                <UserCircleAvartar :name="`${user.first_name} ${user.last_name}`" />

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">{{
                                                        user.first_name + ' ' + user.last_name }}
                                                    </div>
                                                    <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                                        user.email
                                                    }}
                                                    </div>
                                                </div>
                                            </td>

                                            <td
                                                class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                {{ user.phone_number }}</td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <span
                                                    class="bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                                    {{ user?.roles[0].name }}</span>
                                            </td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <label class="relative inline-flex items-center mb-4 mt-8 cursor-pointer">
                                                    <input type="checkbox" value="" class="sr-only peer" checked
                                                        v-model="user.is_available">
                                                    <div
                                                        class="w-11 h-6 bg-gray-200 rounded-full peer peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600">
                                                    </div>

                                                </label>
                                            </td>
                                            <td v-if="user?.roles[0].name == 'salesman'"
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <!-- {{ user.created_at }} -->
                                                <div
                                                    class="mt-1 flex flex-column text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <span class="text-xs font-medium text-gray-500">
                                                        Route: {{ user?.route?.name }}
                                                    </span>
                                                </div>
                                                <div
                                                    class="mt-1 flex flex-column text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <span class="text-xs font-medium text-gray-500">
                                                        Truck: {{ user?.truck?.make_model }}
                                                    </span>
                                                </div>
                                                <div
                                                    class="mt-1 flex flex-column text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <span class="text-xs font-medium text-gray-500">
                                                        Warehouse: {{ user?.warehouse?.name }}
                                                    </span>

                                                </div>
                                            </td>
                                            <td v-else></td>

                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'user'"
                                                    @delete="confirmDeleteDialog($event, user)"
                                                    @edit="selectRole($event, user)" @view="openViewUserModal(user)" />
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </template>
                            <template v-slot:action-button>
                                <button @click="openAddUserModal()"
                                    class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>

                                    <span>Add user</span>
                                </button>
                            </template>
                        </TableLayout>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="user_data.data.length > 0 ? true : false"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="user_data.from" :to="user_data.to" :total="user_data.total"
                :next_page_url="user_data.next_page_url" :prev_page_url="user_data.prev_page_url" />
        </div>

        <AddUserModal :user="selectedUser" :warehouses="warehouses" :trucks="trucks" :routes="routes" :settings="settings"
            @save="closeAddUserModal()" :roles="roles" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteUser" :type="'user'" />
        <!-- <ViewRoleModal :user="selectedUser" @close="closeViewRoleModal()" :permissions_data="permissions_data"
            @save="closeViewRoleModal" /> -->

    </MainLayout>
</template>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
