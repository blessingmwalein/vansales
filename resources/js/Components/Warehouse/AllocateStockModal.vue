<template>
    <div id="add-stock-modal" tabindex="-1"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-7xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-5 border-b rounded-t dark:border-gray-600">
                    <h3 class="text-xl font-medium text-gray-900 dark:text-white">
                        Allocate Stock
                    </h3>
                    <button @click="$emit('close')" type="button"
                        class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white">
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
                    <form class="" action="#">
                        <div>
                            <label for="description"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Search By Description
                                or Code</label>
                            <VueMultiselect v-model="selected" :searchable="true" :options="options"
                                :custom-label="codeWithName" @search-change="searchProducts" @select="selectProduct">
                            </VueMultiselect>

                        </div>

                    </form>

                    <div class="flex flex-col">
                        <div class="overflow-x-auto">
                            <div class="inline-block min-w-full align-middle">
                                <div class="overflow-hidden shadow">

                                    <table class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
                                        <thead class="bg-gray-100 dark:bg-gray-700">
                                            <tr>

                                                <th scope="col"
                                                    class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                    Product Code
                                                </th>
                                                <th scope="col"
                                                    class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                    Product Name
                                                </th>
                                                <th scope="col"
                                                    class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                    Quantity
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
                                                v-for="product in selectedProducts">


                                                <td
                                                    class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                    {{ product.productCode }}</td>
                                                <td
                                                    class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                    {{ product.productName }}</td>


                                                <td
                                                    class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                    <input type="number" id="reorder_level" v-model="product.quantity"
                                                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">
                                                </td>
                                                <td
                                                    class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                    <button type="button" @click="removeProduct(product)"
                                                        class=" items-center p-2 text-sm font-medium text-center text-white bg-red-600 rounded-lg hover:bg-red-800 focus:ring-4 focus:ring-red-300 dark:focus:ring-red-900">
                                                        <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                                                            xmlns="http://www.w3.org/2000/svg">
                                                            <path fill-rule="evenodd"
                                                                d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z"
                                                                clip-rule="evenodd"></path>
                                                        </svg>

                                                    </button>
                                                </td>


                                            </tr>


                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- Modal footer -->
                <div class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600">
                    <button type="button" @click="submit" :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Allocate</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import VueMultiselect from 'vue-multiselect'
import { useForm } from '@inertiajs/vue3';

export default {
    props: ['warehouse'],
    components: {
        VueMultiselect
    },
    data() {
        return {
            selectedProducts: [],
            options: [],
            form: useForm({
                warehouse_id: this.warehouse?.id || null,
                products: [],
            })
        }
    },

    methods: {
        searchProducts(value, loading) {
            axios
                .post(`/company/products-search`, {
                    search: value
                })
                .then((response) => {
                    this.options = response.data.data.map((product) => {
                        return {
                            label: `${product.code} - ${product.description}`,
                            value: product.id,
                            productCode: product.code,
                            productName: product.description,
                        };
                    });
                })
                .catch((error) => {
                    console.log(error);

                });
        },

        checkIfProductExists(product) {
            return this.selectedProducts.some((selectedProduct) => {
                return selectedProduct.value === product.value;
            });
        },

        codeWithName({
            label
        }) {
            return label;
        },

        selectProduct(product) {
            if (this.checkIfProductExists(product)) {
                return;
            }
            this.selectedProducts.push(
                {
                    'quantity': 0,
                    ...product
                }
            );
        },

        removeProduct(product) {
            this.selectedProducts = this.selectedProducts.filter((selectedProduct) => {
                return selectedProduct.value !== product.value;
            });
        },

        submit() {
            this.form.products = this.selectedProducts;
            this.form.post('/company/allocate-stock', {
                preserveScroll: true,
                onSuccess: () => {
                    this.selectedProducts = [];
                    this.$emit('save');
                }
            });
        }
    },

    watch: {
        // Watch the 'tax' prop for changes
        warehouse: {
            handler(newValue) {
                this.form.warehouse_id = newValue?.id || null;
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}

</script>

<style src="vue-multiselect/dist/vue-multiselect.css"></style>
