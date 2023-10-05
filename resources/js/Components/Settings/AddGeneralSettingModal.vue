<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="add-general-setting-modal">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ generalSetting ? "Edit Setting" : 'Create Setting' }}
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
                    <form action="#">

                        <div>
                            <label for="email"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
                            <input type="text" name="name" id="name"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                v-model="form.name">
                            <InputError class="mt-2" :message="form.errors.name" />
                        </div>
                        <div>
                            <label for="type"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white mt-2">Type</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="form.type" :options="typesOptions" :multiple="false" label="name" track-by="id"
                                :custom-label="returnFormatedName">
                            </multiselect>
                            <InputError class="mt-2" :message="form.errors.type" />
                        </div>
                        <div>
                            <label class="relative inline-flex items-center mb-4 cursor-pointer mt-4">
                                <input type="checkbox" value="" v-model="form.value" class="sr-only peer" checked>
                                <div
                                    class="w-11 h-6 bg-gray-200 rounded-full peer peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600">
                                </div>
                                <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Is Active</span>
                            </label>
                            <InputError class="mt-2" :message="form.errors.value" />
                        </div>
                    </form>
                </div>
                <!-- Modal footer -->
                <div class="items-center p-6 border-t border-gray-200 rounded-b dark:border-gray-700">
                    <button type="submit" @click="submitForm()" :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        class=" px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Create</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import InputError from '@/Components/InputError.vue';
import { useForm } from '@inertiajs/vue3';
import { Modal } from 'flowbite';
import Multiselect from 'vue-multiselect'

export default {
    components: { InputError, Multiselect },
    props: ['generalSetting'],
    mounted() {


    },
    data() {
        return {
            form: useForm({
                name: this.generalSetting?.name || '',
                id: this.generalSetting?.id || null,
                type: this.generalSetting?.type || '',
                value: this.generalSetting?.value || false,
            }),
            typesOptions: [
                { id: '1', name: 'Warehouse' },
                { id: '2', name: 'Trucks' },
            ],
        }
    },

    methods: {
        submitForm() {
            if (this.generalSetting) {
                this.update();
            } else {
                this.create();
            }

        },

        create() {
            this.form.type = this.form.type.name;
            this.form.post('/admin/settings/general-settings', {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },

        update() {
            this.form.put(`/admin/settings/general-settings/${this.generalSetting.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        }
    },

    watch: {
        // Watch the 'generalSetting' prop for changes
        generalSetting: {
            handler(newValue) {
                // Update the 'form' data when 'generalSetting' prop changes
                this.form.name = newValue?.name || '';
                this.form.id = newValue?.id || null;
                this.form.type = newValue?.type || '';
                this.form.symbol = newValue?.symbol || '';
                this.form.exchange_rate = newValue?.exchange_rate || '';
                this.form.value = newValue?.value == 1 ? true : false || false;
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
