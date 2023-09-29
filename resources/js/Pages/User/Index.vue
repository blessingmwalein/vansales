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
        TableLayout
    },

    props: ['users', 'roles'],
    data() {
        return {
            selectedUser: null,
            addUserModal: null,
            deleteModal: null,
            viewUserModal: null,
        }
    },
    mounted() {
        const $targetEl = document.getElementById('add-user-modal');
        this.addUserModal = new Modal($targetEl);

        const $deleteModalEl = document.getElementById('delete-user-modal');
        this.deleteModal = new Modal($deleteModalEl);

        const $viewRoleModalEl = document.getElementById('view-user-modal');
        this.viewUserModal = new Modal($viewRoleModalEl);
    },


    methods: {
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
        }
    },


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
                    <div
                        class="items-center hidden mb-3 sm:flex sm:divide-x sm:divide-gray-100 sm:mb-0 dark:divide-gray-700">
                        <form class="lg:pr-3" action="#" method="GET">
                            <label for="users-search" class="sr-only">Search</label>
                            <div class="relative mt-1 lg:w-64 xl:w-96">
                                <input type="text" name="email" id="users-search"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                    placeholder="Search for users">
                            </div>
                        </form>
                    </div>
                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
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
                    <div class="overflow-hidden shadow">
                        <TableLayout :hasData="users.data.length > 0 ? true : false">
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
                                                Created At
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700" v-for="user in users.data">

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
                                                {{ user.created_at }}</td>

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
        <div v-if="users.data.length > 0 ? true : false"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="users.from" :to="users.to" :total="users.total" :next_page_url="users.next_page_url"
                :prev_page_url="users.prev_page_url" />
        </div>

        <AddUserModal :user="selectedUser" @save="closeAddUserModal()" :roles="roles" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteUser" :type="'user'" />
        <!-- <ViewRoleModal :user="selectedUser" @close="closeViewRoleModal()" :permissions_data="permissions_data"
            @save="closeViewRoleModal" /> -->

    </MainLayout>
</template>
