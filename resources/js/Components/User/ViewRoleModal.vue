<template>
    <div id="view-role-modal" tabindex="-1" aria-hidden="true"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-4xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600">
                    <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                        {{ role?.name }}
                    </h3>
                    <button type="button"
                        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
                        @click="$emit('close')">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6" />
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-6 space-y-6">
                    <div class="grid grid-cols-2 md:grid-cols-3">
                        <div v-if="role?.permissions" v-for="permission in role?.permissions" :key="permission.id">

                            <span
                                class="h-auto max-w-full inline-flex items-center px-2 py-1 mr-2 text-sm font-medium text-blue-800 bg-blue-100 rounded dark:bg-blue-900 dark:text-blue-300">
                                {{ permission.name }}
                                <button type="button"
                                    class="inline-flex items-center p-1 ml-2 text-sm text-blue-400 bg-transparent rounded-sm hover:bg-blue-200 hover:text-blue-900 dark:hover:bg-blue-800 dark:hover:text-blue-300"
                                    data-dismiss-target="#badge-dismiss-default" aria-label="Remove">

                                    <i class="bi bi-trash w-4 h-4 "></i>
                                    <span class="sr-only">Remove badge</span>
                                </button>
                            </span>
                            <!-- <img class="h-auto max-w-full rounded-lg"
                            src="https://flowbite.s3.amazonaws.com/docs/gallery/square/image.jpg" alt=""> -->
                        </div>

                    </div>
                </div>
                <!-- Modal footer -->
                <div class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600">
                    <div>
                        <label for="category"
                            class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Permission</label>
                        <select id="category" v-model="form.permission_id"
                            class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                            <option :value="permission.id" v-for="permission in permissions_data">{{ permission.name }}
                            </option>

                        </select>
                        <InputError class="mt-2" :message="form.errors.permission_id" />

                    </div>
                    <button type="button" @click.prevent="submitForm()" :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        class="mt-7 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Attach
                        Permission</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import InputError from '@/Components/InputError.vue';
import { useForm } from '@inertiajs/vue3';
import { Modal } from 'flowbite';

export default {
    components: { InputError },
    props: ['role', 'permissions_data'],
    mounted() {

    },
    data() {
        return {
            form: useForm({
                permission_id: null,
                role_id: this.role?.id ?? null,
            })
        }
    },

    methods: {
        submitForm() {
            this.form.post('/admin/assign-role-permission', {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },
    },

    watch: {
        // Watch the 'role' prop for changes
        role: {
            handler(newValue) {
                this.form.role_id = newValue?.id ?? null;
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>