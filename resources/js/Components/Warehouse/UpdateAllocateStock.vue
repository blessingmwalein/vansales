<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="update-allocate-stock">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ stock ? `Edit Stock - ${stock?.product.code}` : 'Create Stock' }}
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
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Quantity</label>
                            <input type="number" name="quantity" id="quantity"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                v-model="formBind.quantity">
                            <!-- <InputError class="mt-2" :message="form.errors.quantity" /> -->
                        </div>
                    </form>
                </div>
                <!-- Modal footer -->
                <div class="items-center p-6 border-t border-gray-200 rounded-b dark:border-gray-700">
                    <button type="submit" @click="submitForm()" :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        class=" px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Update</button>
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
    props: ['stock', 'warehouse'],
    mounted() {


    },
    data() {
        return {
            formBind: useForm({
                quantity: this.stock?.quantity || ''
            }),
            form: useForm({
                warehouse_id: this.warehouse?.id || null,
                products: [{
                    value: this.stock?.product.id,
                    productCode: this.stock?.product.code,
                    productName: this.stock?.product.description,
                    quantity: this.stock?.quantity || null,
                }],
            })
        }
    },

    methods: {
        submitForm() {
            //update form
            this.form.products[0].quantity = this.formBind.quantity;
            this.form.products[0].value = this.stock.product.id;
            this.form.products[0].productCode = this.stock.product.code;
            this.form.products[0].productName = this.stock.product.description;
            this.form.post('/admin/allocate-stock', {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },

    },
    watch: {
        // Watch the 'stock' prop for changes
        stock: {
            handler(newValue) {
                this.formBind.quantity = newValue?.quantity;
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>