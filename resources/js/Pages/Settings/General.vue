<script >
import BreadCrumb from '@/Components/BreadCrumb.vue';
import CopyButton from '@/Components/CopyButton.vue';
import ConfirmDeleteDialog from '@/Components/ConfirmDeleteDialog.vue';
import Pagination from '@/Components/Pagination.vue';
import TableActionButtons from '@/Components/TableActionButtons.vue';
import TableLayout from '@/Components/TableLayout.vue';
import AddGeneralSettingModal from '@/Components/Settings/AddGeneralSettingModal.vue';
import MainLayout from '@/Layouts/MainLayout.vue';
import globalMixin from "@/Mixins/global.js";
import Multiselect from 'vue-multiselect'
// import { Modal } from 'flowbite';


export default {
    components: {
        BreadCrumb,
        ConfirmDeleteDialog,
        Pagination,
        TableActionButtons,
        AddGeneralSettingModal,
        MainLayout,
        CopyButton,
        TableLayout,
        Multiselect
    },
    mixins: [globalMixin],

    props: ['generalSettings'],
    data() {
        return {
            general_setting_data: this.generalSettings,
            addGeneralSettingModal: null,
            hasSettingChanged: false,
            isLoading: false
        }
    },
    mounted() {
        const $targetEl = document.getElementById('add-general-setting-modal');
        this.addGeneralSettingModal = new Modal($targetEl);

    },

    methods: {
        openAddGeneralSettingModal() {
            this.addGeneralSettingModal.show();
        },

        closeGeneralSettingModal() {
            this.addGeneralSettingModal.hide();
        },


        deleteGeneralSetting() {
            this.$inertia.delete(`/admin/settings/general-settings/${this.selectedGeneralSetting.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.closeDeleteModal();
                    this.$emit('save');
                }
            });
        },

        updateSettings() {
            this.isLoading = true;
            this.$inertia.post(`/admin/settings/update-general-settings`, {
                general_settings: this.general_setting_data
            },
                {
                    preserveScroll: true,
                    onSuccess: () => {
                        this.isLoading = false;
                        this.hasSettingChanged = false;
                    },
                    onError: () => {
                        this.isLoading = false;
                        this.hasSettingChanged = false;
                    },
                    onFinish: () => {
                        this.isLoading = false;
                        this.hasSettingChanged = false;

                    }
                });
        }
    },

    watch: {
        generalSettings: {
            handler(newValue) {
                this.general_setting_data = newValue;
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
                    <BreadCrumb :title="'Settings/General Settings'" />
                    <h1 class="text-xl font-semibold text-gray-900 sm:text-2xl dark:text-white">General Settings</h1>
                </div>
                <div class="sm:flex">

                    <div class="flex items-center ml-auto space-x-2 sm:space-x-3">



                        <button type="button" @click="openAddGeneralSettingModal()"
                            class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                            <svg class="w-5 h-5 mr-2 -ml-1" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"></path>
                            </svg>
                            Add Setting
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex flex-col">
            <div class="overflow-x-auto">
                <div class="inline-block min-w-full align-middle">

                    <div class="grid grid-cols-1 px-4 xl:grid-cols-1 xl:gap-4 mt-4">
                        <div
                            class="p-4 mb-4 bg-white border border-gray-200 rounded-lg shadow-sm dark:border-gray-700 sm:p-6 dark:bg-gray-800 xl:mb-0">
                            <div class="flow-root">

                                <div class="divide-y divide-gray-200 dark:divide-gray-700">
                                    <!-- Item 1 -->
                                    <div class="flex items-center justify-between py-4"
                                        v-for="(setting, index) in general_setting_data">
                                        <div class="flex flex-col flex-grow">
                                            <div class="text-lg font-semibold text-gray-900 dark:text-white">
                                                {{ setting.type }}
                                            </div>
                                            <div class="text-base font-normal text-gray-500 dark:text-gray-400">
                                                {{ setting.name }}
                                            </div>
                                        </div>
                                        <label :for="'company-news-' + index"
                                            class="relative flex items-center cursor-pointer">
                                            <input type="checkbox" :id="'company-news-' + index" v-model="setting.value"
                                                @change="hasSettingChanged = true" class="sr-only">
                                            <span
                                                class="h-6 bg-gray-200 border border-gray-200 rounded-full w-11 toggle-bg dark:bg-gray-700 dark:border-gray-600"></span>
                                        </label>
                                    </div>

                                </div>
                                <div class="mt-6" v-if="hasSettingChanged">
                                    <button type="button" @click="updateSettings()" :class="{ 'opacity-25': isLoading }"
                                        :disabled="isLoading"
                                        class="inline-flex items-center justify-center px-3 py-2 text-sm font-medium text-center text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                                        Update Changes
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>


        <AddGeneralSettingModal :generalSetting="selectedGeneralSetting" @save="closeGeneralSettingModal()" />
        <ConfirmDeleteDialog @cancel="closeDeleteModal" @yes="deleteProduct" :type="'generalSetting'" />
    </MainLayout>
</template>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
