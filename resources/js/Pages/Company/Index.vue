<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddCompanyModal from '@/Components/Company/AddCompanyModal.vue';
import EditCompanyModal from '@/Components/Company/EditCompanyModal.vue';
import ViewCompanyModal from '@/Components/Company/ViewCompanyModal.vue';
import CompanyCircleAvartar from '@/Components/UserCircleAvartar.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import Multiselect from 'vue-multiselect'


export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddCompanyModal,
        MainLayout,
        CompanyCircleAvartar,
        TableLayout,
        Multiselect,
        ViewCompanyModal,
        EditCompanyModal
    },

    props: ['companies', 'subscriptions', 'roles'],
    data() {
        return {
            company_data: this.companies,
            selectedCompany: null,
            addCompanyModal: null,
            viewCompanyModal: null,
            editCompanyModal : null,
            deleteModal: null,
            rolesOptions: [],
            showSearchForm: true,
            isLoading: false,
            searchForm: {
                city: null,
                date_range: null,
                bpn: null,
                name: null,
                email: null,
                phone: null,
            },
        }
    },
    mounted() {
        this.updateOptions();
        const $targetEl = document.getElementById('add-company-modal');
        this.addCompanyModal = new Modal($targetEl);

        const $targetEditCompanyEl = document.getElementById('edit-company-modal');
        this.editCompanyModal = new Modal($targetEditCompanyEl);


        const $deleteModalEl = document.getElementById('delete-company-modal');
        this.deleteModal = new Modal($deleteModalEl);

        const $viewCompanyModalEl = document.getElementById('view-company-modal');
        this.viewCompanyModal = new Modal($viewCompanyModalEl);


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
        openAddCompanyModal() {
            this.selectedCompany = null;
            this.addCompanyModal.show();
        },


        openEditCompanyModal(company) {
            this.selectedCompany = company;
            this.editCompanyModal.show();
        },

        openViewCompanyModal(company) {
            this.selectedCompany = company;

            // console.log(this.selectedCompany);
            this.viewCompanyModal.show();
        },
        closeAddCompanyModal() {
            this.addCompanyModal.hide();
        },

        closeEditCompanyModal() {
            this.selectedCompany = null;
            this.addCompanyModal.hide();
        },
        closeDeleteModal() {
            this.deleteModal.hide();
        },
        closeViewCompanyModal() {
            this.viewCompanyModal.hide();
        },
        deleteCompany() {
            this.$inertia.delete(`/admin/companies/${this.selectedCompany.id}`, {
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
        selectCompany(event, company) {
            this.selectedCompany = company;
            this.addCompanyModal.show();
        },
        confirmDeleteDialog(event, company) {
            this.selectedCompany = company;
            this.deleteModal.show();
        },
        submitSearch() {
            this.isLoading = true;

            const { role } = this.searchForm
            axios.post(`/admin/companies-search`, {
                'from': this.searchForm.date_range ? this.searchForm.date_range[0] : '',
                'to': this.searchForm.date_range ? this.searchForm.date_range[1] : '',
                'name': this.searchForm.name,
                'email': this.searchForm.email,
                'phone': this.searchForm.phone,
                'city': this.searchForm.city,
                'bpn': this.searchForm.bpn,
            })
                .then((response) => {
                    console.log(response);
                    this.company_data = response.data;
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
        companies: function (val) {
            this.company_data = val;
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
                    <BreadCrumb :title="'Companies'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Companies</h1>
                </div>
                <div class="sm:flex">

                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">
                        <button type="button" @click="showSearchForm = !showSearchForm"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-green-700 hover:bg-green-800 focus:outline-none focus:ring-4 focus:ring-green-300 rounded-lg dark:focus:ring-yellow-900 text-sm px-5 py-2.5 mr-2 mb-2">

                            <i class=" w-5 h-5 mr-2 -ml-1"
                                :class="{ 'bi bi-dash-lg': showSearchForm, 'bi bi-plus-lg': !showSearchForm }"></i>
                            Hide Search Form
                        </button>

                        <button type="button" @click="openAddCompanyModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">

                            <i class="bi bi-person-plus-fill w-5 h-5 mr-2 -ml-1"></i>
                            Add Company
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
                            <input type="text" name="email" id="companies-search" v-model="searchForm.name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>

                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
                            <input type="text" name="email" id="companies-search" v-model="searchForm.email"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Bpn</label>
                            <input type="text" name="email" id="companies-search" v-model="searchForm.bpn"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>
                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone Number</label>
                            <input type="text" name="email" id="companies-search" v-model="searchForm.phone"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                        </div>

                        <div>
                            <label for="item-weight"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">City</label>
                            <input type="text" name="email" id="companies-search" v-model="searchForm.city"
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
                        <TableLayout :hasData="company_data.data.length > 0 ? true : false" :isLoading="isLoading">
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
                                                Name, Email
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Phone Number
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                City
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Bpn
                                            </th>
                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Subscription
                                            </th>

                                            <th scope="col"
                                                class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                        <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                            v-for="company in company_data.data">

                                            <td class="w-4 p-4">
                                                <div class="flex items-center">
                                                    <input :id="`checkbox-${company.id}`" aria-describedby="checkbox-1"
                                                        type="checkbox"
                                                        class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                    <label :for="`checkbox-${company.id}`" class="sr-only">checkbox</label>
                                                </div>
                                            </td>
                                            <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">
                                                <CompanyCircleAvartar :name="`${company.name}`" />

                                                <div class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                    <div class="text-base font-semibold text-gray-900 dark:text-white">{{
                                                        company.name }}
                                                    </div>
                                                    <div class="text-sm font-normal text-gray-500 dark:text-gray-400">{{
                                                        company.email
                                                    }}
                                                    </div>
                                                </div>
                                            </td>

                                            <td
                                                class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                {{ company.phone }}</td>
                                            <td
                                                class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                {{ company.city }}</td>
                                            <td
                                                class="max-w-sm p-4 overflow-hidden text-base font-normal text-gray-500 truncate xl:max-w-xs dark:text-gray-400">
                                                {{ company.bpn }}</td>
                                            <td
                                                class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                <span
                                                    class="bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                                    {{ company.subscription_period }} {{ company.subscription_name }}</span>
                                            </td>

                                            <td class="p-4 space-x-2 whitespace-nowrap">
                                                <TableActionButtons :type="'company'"
                                                    @delete="confirmDeleteDialog($event, company)"
                                                    @edit="openEditCompanyModal(company)"
                                                    @view="openViewCompanyModal(company)" />
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </template>
                            <template v-slot:action-button>
                                <button @click="openAddCompanyModal()"
                                    class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>

                                    <span>Add company</span>
                                </button>
                            </template>
                        </TableLayout>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="company_data.data.length > 0"
            class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
            <Pagination :from="company_data.meta.from" :to="company_data.meta.to" :total="company_data.meta.total"
                :next_page_url="company_data.links.next" :prev_page_url="company_data.links.prev" />
        </div>
        <ViewCompanyModal :company="selectedCompany" @save="closeViewCompanyModal()" />
        <AddCompanyModal :company="selectedCompany" :subscriptions="subscriptions" @save="closeAddCompanyModal()"
            :roles="roles" />
        <EditCompanyModal :company="selectedCompany" :subscriptions="subscriptions" @save="closeEditCompanyModal()"
            :roles="roles" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteCompany" :type="'company'" />
        <!-- <ViewRoleModal :company="selectedCompany" @close="closeViewRoleModal()" :permissions_data="permissions_data"
            @save="closeViewRoleModal" /> -->
    </MainLayout>
</template>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
