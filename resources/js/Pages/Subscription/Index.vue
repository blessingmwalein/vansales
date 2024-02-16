<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddSubscriptionModal from '@/Components/Subscription/AddSubscriptionModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import Multiselect from 'vue-multiselect'
import UserCircleAvartar from '@/Components/UserCircleAvartar.vue';


export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddSubscriptionModal,
        MainLayout,
        TableLayout,
        Multiselect,
        UserCircleAvartar
    },

    props: ['subscriptions', 'features'],
    data() {
        return {
            subscription_data: this.subscriptions,
            selectedSubscription: null,
            addSubscriptionModal: null,
            deleteModal: null,
            viewSubscriptionModal: null,
            showSearchForm: true,
            isLoading: false,
            searchForm: {
                name: null,
                price: null,
                date_range: null,
            },
        }
    },
    mounted() {
        const $targetEl = document.getElementById('add-subscription-modal');
        this.addSubscriptionModal = new Modal($targetEl);

        const $deleteModalEl = document.getElementById('delete-subscription-modal');
        this.deleteModal = new Modal($deleteModalEl);

        const $viewSubscriptionModalEl = document.getElementById('view-subscription-modal');
        this.viewSubscriptionModal = new Modal($viewSubscriptionModalEl);
    },


    methods: {

        returnFormatedName({ name }) {
            return name;
        },
        openAddSubscriptionModal() {
            this.selectedSubscription = null;
            this.addSubscriptionModal.show();
        },
        openViewSubscriptionModal(subscription) {
            this.selectedSubscription = subscription;
            this.viewSubscriptionModal.show();
        },
        closeAddSubscriptionModal() {
            this.addSubscriptionModal.hide();
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },
        closeViewRoleModal() {
            this.viewSubscriptionModal.hide();
        },
        deleteSubscription() {
            this.$inertia.delete(`/admin/subscriptions/${this.selectedSubscription.id}`, {
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
        selectSubscription(event, subscription) {
            this.selectedSubscription = subscription;
            this.addSubscriptionModal.show();
        },
        confirmDeleteDialog(event, subscription) {
            this.selectedSubscription = subscription;
            this.deleteModal.show();
        },
        submitSearch() {
            this.isLoading = true;

            const { role } = this.searchForm
            axios.post(`/admin/search-subscriptions`, {
                role: role ? role.id : null,
                ...this.searchForm
            })
                .then((response) => {
                    console.log(response);
                    this.subscription_data = response.data;
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
        subscriptions: function (val) {
            this.subscription_data = val;
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
                    <BreadCrumb :title="'Subscriptions'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Subscriptions</h1>
                </div>
                <div class="sm:flex">

                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="showSearchForm = !showSearchForm"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-4 focus:ring-green-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                            <i class=" w-5 h-5 mr-2 -ml-1"
                                :class="{ 'bi bi-dash-lg': showSearchForm, 'bi bi-plus-lg': !showSearchForm }"></i>
                            Hide Search Form
                        </button>

                        <button type="button" @click="openAddSubscriptionModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">

                            <i class="bi bi-person-plus-fill w-5 h-5 mr-2 -ml-1"></i>
                            Add Subscription
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
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
                            <input type="text" name="email" id="subscriptions-search" v-model="searchForm.name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>

                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Price</label>
                            <input type="text" name="email" id="subscriptions-search" v-model="searchForm.price"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
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
                        <TableLayout :hasData="subscription_data.data.length > 0 ? true : false" :isLoading="isLoading">
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
                                                Price
                                            </th>


                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                            v-for="subscription in subscription_data.data">

                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input :id="`checkbox-${subscription.id}`" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label :for="`checkbox-${subscription.id}`"
                                                        class="sr-only">checkbox</label>
                                                </div>
                                            </td>
                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">
                                                <UserCircleAvartar :name="`${subscription.name}`" />

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">{{
                                                        subscription.name }}
                                                    </div>
                                                    <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                                        subscription.description
                                                    }}
                                                    </div>
                                                </div>
                                            </td>

                                            <td
                                                class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                ${{ subscription.price }}</td>
                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'subscription'"
                                                    @delete="confirmDeleteDialog($event, subscription)"
                                                    @edit="selectSubscription($event, subscription)"
                                                    @view="openViewSubscriptionModal(subscription)" />
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </template>
                            <template v-slot:action-button>
                                <button @click="openAddSubscriptionModal()"
                                    class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>

                                    <span>Add subscription</span>
                                </button>
                            </template>
                        </TableLayout>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="subscription_data.data.length > 0 ? true : false"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="subscription_data.from" :to="subscription_data.to" :total="subscription_data.total"
                :next_page_url="subscription_data.next_page_url" :prev_page_url="subscription_data.prev_page_url" />
        </div>

        <AddSubscriptionModal :subscription="selectedSubscription" :features="features"
            @save="closeAddSubscriptionModal()" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteSubscription" :type="'subscription'" />
        <!-- <ViewRoleModal :subscription="selectedSubscription" @close="closeViewRoleModal()" :permissions_data="permissions_data"
            @save="closeViewRoleModal" /> -->
    </MainLayout>
</template>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
