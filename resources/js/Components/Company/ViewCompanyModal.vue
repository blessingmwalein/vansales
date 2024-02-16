<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="view-company-modal">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ company?.name }}
                    </h3>
                    <button type="button"
                        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-700 dark:hover:text-white"
                        @click="$emit('save')">
                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                clip-rule="evenodd"></path>
                        </svg>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-6 space-y-6">
                    <div className="p-4">
                        <ul
                            className="mb-4 w-full text-xm font-normal text-gray-900 bg-white border border-gray-200 rounded-lg dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Name:</span>
                                <span className="w-3/4">{{ company?.name }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Description:</span>
                                <span className="w-3/4">{{ company?.description }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">City:</span>
                                <span className="w-3/4">{{ company?.city }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Address:</span>
                                <span className="w-3/4">{{ company?.address }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Bpn:</span>
                                <span className="w-3/4">{{ company?.bpn }}</span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Phone:</span>
                                <span className="w-3/4">{{ company?.phone }}</span>
                            </li>

                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">Package:</span>
                                <span className="w-3/4">

                                    <span
                                        class="bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                        {{ company?.subscription_period }} {{ company?.subscription_name }}</span>
                                </span>
                            </li>
                            <li
                                className="w-full px-4 py-2 border-b border-gray-200 flex justify-between items-center dark:border-gray-600">
                                <span className="w-1/4 flex-grow-0 flex-shrink-0 text-gray-500">General Settings:</span>
                                <span className="w-3/4">


                                    <span v-if="company?.hasGeneralSettings"
                                        class="bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-2.5 py-0.5 rounded-full dark:bg-blue-900 dark:text-blue-300">
                                        Yes</span>
                                    <Button v-else @click="setDefaultSettings"
                                        class="bg-red-100 text-red-800 text-xs font-medium mr-2 px-2.5 py-2 rounded-full dark:bg-red-900 dark:text-red-300">
                                        Set General Settings</Button>
                                </span>
                            </li>
                        </ul>
                    </div>


                </div>
                <!-- Modal footer -->
                <!-- <div class="items-center p-6 border-t border-gray-200 rounded-b dark:border-gray-700">
                    <button type="submit" @click="submitForm()" :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        class=" px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Create</button>
                </div> -->
            </div>
        </div>
    </div>
</template>
<script>
import InputError from '@/Components/InputError.vue';
import { useForm } from '@inertiajs/vue3';
import { Modal } from 'flowbite';
import Multiselect from 'vue-multiselect'
import globalMixin from "@/Mixins/global.js";


export default {
    props: ['company'],
    mixins: [globalMixin],
    mounted() {
        // console.log(this.company);
    },
    data() {
        return {
            company_data: this.company,
            form: useForm({
                company_id: this.company?.id ?? null,
            }),
        }
    },

    methods: {

        setDefaultSettings() {

            this.form.company_id = this.company?.id;
            this.form.post(`/company/settings/set-default-general-settings`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset();
                    this.$emit('save');
                }
            });
        },


    },

    watch: {
        // Watch the 'company' prop for changes
        company: {
            handler(newValue) {
                console.log(newValue);
                // this.company_data?.name = newValue?.name;
                // this.company_data?.email = newValue?.email;
                // this.company_data?.phone = newValue?.phone;
                // this.company_data?.address = newValue?.address;
                // this.company_data?.city = newValue?.city;
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
