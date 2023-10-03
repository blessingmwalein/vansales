<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import AddCurrencyModal from '@/Components/Settings/AddCurrencyModal.vue';
import AddPricingMethodModal from '@/Components/Settings/AddPricingMethodModal.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddProductCategoryModal from '@/Components/Warehouse/AddProductCategoryModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddProductCategoryModal,
        MainLayout,
        CopyButton,
        TableLayout,
        AddCurrencyModal,
        AddPricingMethodModal
    },
    mixins: [globalMixin],

    props: ['currencies', 'pricingMethods', 'productPricings'],
    data() {
        return {
            activeTab: 'currencies',
            selectedCurrency: null,
            selectedPricingMethod: null,
            addCurrencyModal: null,
            addPricingMethodModal: null,
            deleteCurrencyModal: null,
            deletePricingMethodModal: null,
        }
    },
    mounted() {

        const $targetEl = document.getElementById('add-currency-modal');
        this.addCurrencyModal = new Modal($targetEl);

        const $targetElPricingMethod = document.getElementById('add-pricing-method-modal');
        this.addPricingMethodModal = new Modal($targetElPricingMethod);

        const $deleteCurrencyModalEl = document.getElementById('delete-currency-modal');
        this.deleteCurrencyModal = new Modal($deleteCurrencyModalEl);

        const $deletePricingMethodModalEl = document.getElementById('delete-pricing-method-modal');
        this.deletePricingMethodModal = new Modal($deletePricingMethodModalEl);
    },


    methods: {
        openAddCurrencyModal() {
            this.selectedCurrency = null;
            this.addCurrencyModal.show();
        },
        openAddPricingMethodModal() {
            this.selectedPricingMethod = null;
            this.addPricingMethodModal.show();
        },

        closeAddCurrencyModal() {
            this.addCurrencyModal.hide();
        },
        closeAddPricingMethodModal() {
            this.addPricingMethodModal.hide();
        },

        closeDeleteCurrencyModal() {
            this.deleteCurrencyModal.hide();
        },
        closeDeletePricingMethodModal() {
            this.deletePricingMethodModal.hide();
        },

        deleteCurrency() {
            this.$inertia.delete(`/admin/currencies/${this.selectedCurrency.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.closeDeleteCurrencyModal();
                }
            });
        },
        deletePricingMethod() {
            this.$inertia.delete(`/admin/pricing-methods/${this.selectedPricingMethod.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.closeDeletePricingMethodModal();
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
        selectCurrency(event, currency) {
            this.selectedCurrency = currency;
            this.addCurrencyModal.show();
        },

        selectPricingMethod(event, pricingMethod) {
            this.selectedPricingMethod = pricingMethod;
            this.addPricingMethodModal.show();
        },
        confirmDeleteCurrencyDialog(event, currency) {
            this.selectedCurrency = currency;
            this.deleteCurrencyModal.show();
        },
        confirmDeletePricingMethodDialog(event, pricingMethod) {
            this.selectedPricingMethod = pricingMethod;
            this.deletePricingMethodModal.show();
        },

        toggleTab(id) {
            this.activeTab = id;
            if (id == 'currencies') {
                document.getElementById('currencies').classList.remove('hidden');
                document.getElementById('pricingMethods').classList.add('hidden');
            } else {
                document.getElementById('currencies').classList.add('hidden');
                document.getElementById('pricingMethods').classList.remove('hidden');
            }
        }
    },


}
</script>

<template>
    <MainLayout>

        <div
            class="p-4 bg-white block sm:flex items-center justify-between border-b border-gray-200 lg:mt-1.5 dark:bg-gray-800 dark:border-gray-700">
            <div class="w-full mb-1">
                <div class="mb-4">
                    <BreadCrumb :title="'Products/Settings'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Product Settings</h1>
                </div>

            </div>
        </div>

        <div class="mb-4 border-b border-gray-200 dark:border-gray-700">
            <ul class="flex flex-wrap -mb-px text-sm font-medium text-center" role="tablist">
                <li class="mr-2">
                    <button class="inline-block p-4  rounded-t-lg" type="button"
                        :class="{ 'activeTab': activeTab == 'currencies' }"
                        @click="toggleTab('currencies')">Currencies</button>
                </li>
                <li class="mr-2">
                    <button @click="toggleTab('pricingMethods')" :class="{ 'activeTab': activeTab == 'pricingMethods' }"
                        class="inline-block p-4  border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button">Pricing Methods</button>
                </li>
            </ul>
        </div>
        <div>
            <div class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="currencies">
                <button type="button" @click="openAddCurrencyModal()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                    <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                        xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                            d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                            clip-rule="evenodd"></path>
                    </svg>
                    Add Currency
                </button>
                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="currencies.data.length > 0 ? true : false">
                                    <template v-slot:table>
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
                                                        Code
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Symbol
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Exchange Rate
                                                    </th>
                                                    <th scope="col"
                                                        class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                        Is Default
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
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                    v-for="currency in currencies.data">
                                                    <td class="w-4 p-4">
                                                        <div class="flex items-center">
                                                            <input :id="`checkbox-${currency.id}`"
                                                                aria-describedby="checkbox-1" type="checkbox"
                                                                class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                            <label :for="`checkbox-${currency.id}`"
                                                                class="sr-only">checkbox</label>
                                                        </div>
                                                    </td>


                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ currency.name }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ currency.code }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ currency.symbol }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ currency.exchange_rate }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ currency.is_default ==1 ? "Yes" : "No" }}</td>

                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ currency.created_at }}</td>

                                                    <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'unit-measure'" :has_view="false"
                                                            @delete="confirmDeleteCurrencyDialog($event, currency)"
                                                            @edit="selectCurrency($event, currency)" />
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </template>
                                    <template v-slot:action-button>
                                        <button @click="openAddCurrencyModal()"
                                            class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                            <span>Add Currency</span>
                                        </button>
                                    </template>
                                </TableLayout>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="currencies.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="currencies.from" :to="currencies.to" :total="currencies.total"
                        :next_page_url="currencies.next_page_url" :prev_page_url="currencies.prev_page_url" />
                </div>

            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="pricingMethods">
                <button type="button" @click="openAddPricingMethodModal()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                    <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                        xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                            d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                            clip-rule="evenodd"></path>
                    </svg>
                    Add Pricing Method
                </button>
                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="pricingMethods.data.length > 0 ? true : false">
                                    <template v-slot:table>
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
                                                        Is Default
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
                                            <tbody
                                                class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                    v-for="pricingMethod in pricingMethods.data">
                                                    <td class="w-4 p-4">
                                                        <div class="flex items-center">
                                                            <input :id="`checkbox-${pricingMethod.id}`" aria-describedby="checkbox-1"
                                                                type="checkbox"
                                                                class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                            <label :for="`checkbox-${pricingMethod.id}`"
                                                                class="sr-only">checkbox</label>
                                                        </div>
                                                    </td>


                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ pricingMethod.name }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ pricingMethod.is_default ==1 ? "Yes" : "No" }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ pricingMethod.created_at }}</td>

                                                    <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'unit-measure'" :has_view="false"
                                                            @delete="confirmDeletePricingMethodDialog($event, pricingMethod)"
                                                            @edit="selectPricingMethod($event, pricingMethod)" />
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </template>
                                    <template v-slot:action-button>
                                        <button @click="openAddPricingMethodModal()"
                                            class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>
                                            <span>Add Pricing Method</span>
                                        </button>
                                    </template>
                                </TableLayout>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="pricingMethods.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="pricingMethods.from" :to="pricingMethods.to" :total="pricingMethods.total"
                        :next_page_url="pricingMethods.next_page_url" :prev_page_url="pricingMethods.prev_page_url" />
                </div>
            </div>


        </div>

        <AddCurrencyModal :currency="selectedCurrency" @save="closeAddCurrencyModal()" />
        <AddPricingMethodModal :pricingMethod="selectedPricingMethod" @save="closeAddPricingMethodModal()" />
        <ConfirmDeleteDialog @cancel="closeDeletePricingMethodModal" @yes="deletePricingMethod" :type="'pricing-method'" />
        <ConfirmDeleteDialog @cancel="closeDeleteCurrencyModal" @yes="deleteCurrency" :type="'currency'" />
    </MainLayout>
</template>
<style scoped>
.activeTab {
    border-bottom: 4px solid #2563EB;
}
</style>
