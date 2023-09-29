<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import AddUnitMeasureModal from '@/Components/Warehouse/AddUnitMeasureModal.vue';
import AddTaxModal from '@/Components/Warehouse/AddTaxModal.vue';
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
        AddUnitMeasureModal,
        AddTaxModal
    },
    mixins: [globalMixin],

    props: ['unitOfMeasurements', 'taxs'],
    data() {
        return {
            activeTab: 'unitOfMeasurements',
            selectedUnitofMeasure: null,
            selectedTax: null,
            addUnitofMeasureModal: null,
            addTaxModal: null,
            deleteModal: null,
            deleteTaxModal: null,
        }
    },
    mounted() {

        const $targetEl = document.getElementById('add-unit-measure-modal');
        this.addUnitofMeasureModal = new Modal($targetEl);

        const $targetEltax = document.getElementById('add-tax-modal');
        this.addTaxModal = new Modal($targetEltax);

        const $deleteModalEl = document.getElementById('delete-unit-measure-modal');
        this.deleteModal = new Modal($deleteModalEl);

        const $deleteTaxModalEl = document.getElementById('delete-tax-modal');
        this.deleteTaxModal = new Modal($deleteTaxModalEl);
    },


    methods: {
        openAddUnitOfMeasureModal() {
            this.selectedUnitofMeasure = null;
            this.addUnitofMeasureModal.show();
        },
        openAddTaxModal() {
            this.selectedTax = null;
            this.addTaxModal.show();
        },

        closeAddUnitOfMeasureModal() {
            this.addUnitofMeasureModal.hide();
        },
        closeAddTaxModal() {
            this.addTaxModal.hide();
        },

        closeDeleteModal() {
            this.deleteModal.hide();
        },
        closeDeleteTaxModal() {
            this.deleteTaxModal.hide();
        },

        deleteUnitMeasure() {
            this.$inertia.delete(`/admin/unit-measures/${this.selectedUnitofMeasure.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.closeDeleteModal();
                }
            });
        },
        deleteTax() {
            this.$inertia.delete(`/admin/taxs/${this.selectedTax.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.closeDeleteTaxModal();
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
        selectUnitOfMeasure(event, unitOfMeasure) {
            this.selectedUnitofMeasure = unitOfMeasure;
            this.addUnitofMeasureModal.show();
        },

        selectTax(event, tax) {
            this.selectedTax = tax;
            this.addTaxModal.show();
        },
        confirmDeleteDialog(event, unitOfMeasure) {
            this.selectedUnitofMeasure = unitOfMeasure;
            this.deleteModal.show();
        },
        confirmDeleteTaxDialog(event, tax) {
            this.selectedTax = tax;
            this.deleteTaxModal.show();
        },

        toggleTab(id) {
            this.activeTab = id;
            if (id == 'unitOfMeasurements') {
                document.getElementById('unitOfMeasurements').classList.remove('hidden');
                document.getElementById('taxes').classList.add('hidden');
            } else {
                document.getElementById('unitOfMeasurements').classList.add('hidden');
                document.getElementById('taxes').classList.remove('hidden');
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
                    <BreadCrumb :title="'Stock/Utilities'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">Utilities</h1>
                </div>

            </div>
        </div>

        <div class="mb-4 border-b border-gray-200 dark:border-gray-700">
            <ul class="flex flex-wrap -mb-px text-sm font-medium text-center" role="tablist">
                <li class="mr-2">
                    <button class="inline-block p-4  rounded-t-lg" type="button"
                        :class="{ 'activeTab': activeTab == 'unitOfMeasurements' }"
                        @click="toggleTab('unitOfMeasurements')">Unit
                        Of Measure</button>
                </li>
                <li class="mr-2">
                    <button @click="toggleTab('taxes')" :class="{ 'activeTab': activeTab == 'taxes' }"
                        class="inline-block p-4  border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300"
                        type="button">Taxes</button>
                </li>

            </ul>
        </div>
        <div>
            <div class="p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="unitOfMeasurements">
                <button type="button" @click="openAddUnitOfMeasureModal()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                    <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                        xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                            d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                            clip-rule="evenodd"></path>
                    </svg>
                    Add Unit Of Measure
                </button>
                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="unitOfMeasurements.data.length > 0 ? true : false">
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
                                                    v-for="unitOfMeasure in unitOfMeasurements.data">
                                                    <td class="w-4 p-4">
                                                        <div class="flex items-center">
                                                            <input :id="`checkbox-${unitOfMeasure.id}`"
                                                                aria-describedby="checkbox-1" type="checkbox"
                                                                class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                            <label :for="`checkbox-${unitOfMeasure.id}`"
                                                                class="sr-only">checkbox</label>
                                                        </div>
                                                    </td>


                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ unitOfMeasure.name }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ unitOfMeasure.created_at }}</td>

                                                    <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'unit-measure'" :has_view="false"
                                                            @delete="confirmDeleteDialog($event, unitOfMeasure)"
                                                            @edit="selectUnitOfMeasure($event, unitOfMeasure)" />
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </template>
                                    <template v-slot:action-button>
                                        <button @click="openAddUnitOfMeasureModal()"
                                            class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>

                                            <span>Add Unit Measure</span>
                                        </button>
                                    </template>
                                </TableLayout>

                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="unitOfMeasurements.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="unitOfMeasurements.from" :to="unitOfMeasurements.to"
                        :total="unitOfMeasurements.total" :next_page_url="unitOfMeasurements.next_page_url"
                        :prev_page_url="unitOfMeasurements.prev_page_url" />
                </div>

            </div>
            <div class="hidden p-4 rounded-lg bg-gray-50 dark:bg-gray-800" id="taxes">
                <button type="button" @click="openAddTaxModal()"
                    class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                    <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                        xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                            d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                            clip-rule="evenodd"></path>
                    </svg>
                    Add Tax
                </button>
                <div class="flex flex-col">
                    <div class="overflow-x-auto">
                        <div class="inline-block min-w-full align-middle">
                            <div class="overflow-hidden shadow">
                                <TableLayout :hasData="taxs.data.length > 0 ? true : false">
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
                                                        Rate
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
                                                    v-for="tax in taxs.data">
                                                    <td class="w-4 p-4">
                                                        <div class="flex items-center">
                                                            <input :id="`checkbox-${tax.id}`" aria-describedby="checkbox-1"
                                                                type="checkbox"
                                                                class="w-4 h-4 border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:focus:ring-primary-600 dark:ring-offset-gray-800 dark:bg-gray-700 dark:border-gray-600">
                                                            <label :for="`checkbox-${tax.id}`"
                                                                class="sr-only">checkbox</label>
                                                        </div>
                                                    </td>


                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ tax.name }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ tax.rate }}</td>
                                                    <td
                                                        class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                        {{ tax.created_at }}</td>

                                                    <td class="p-4 space-x-2 whitespace-nowrap">
                                                        <TableActionButtons :type="'unit-measure'" :has_view="false"
                                                            @delete="confirmDeleteTaxDialog($event, tax)"
                                                            @edit="selectTax($event, tax)" />
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </template>
                                    <template v-slot:action-button>
                                        <button @click="openAddTaxModal()"
                                            class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                                <path stroke-linecap="round" stroke-linejoin="round"
                                                    d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                            </svg>

                                            <span>Add Tax</span>
                                        </button>
                                    </template>
                                </TableLayout>

                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="taxs.data.length > 0"
                    class="sticky bottom-0 right-0 items-center w-full p-4 bg-white border-t border-gray-200 sm:flex sm:justify-between dark:bg-gray-800 dark:border-gray-700">
                    <Pagination :from="taxs.from" :to="taxs.to" :total="taxs.total" :next_page_url="taxs.next_page_url"
                        :prev_page_url="taxs.prev_page_url" />
                </div>
            </div>


        </div>


        <AddUnitMeasureModal :unitOfMeasure="selectedUnitofMeasure" @save="closeAddUnitOfMeasureModal()" />
        <AddTaxModal :tax="selectedTax" @save="closeAddTaxModal()" />
        <ConfirmDeleteDialog @cancel="closeDeleteTaxModal" @yes="deleteTax" :type="'tax'" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteUnitMeasure" :type="'unit-measure'" />
    </MainLayout>
</template>
<style scoped>
.activeTab {
    border-bottom: 4px solid #2563EB;
}
</style>
