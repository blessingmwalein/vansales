<template>
    <div class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full"
        id="add-product-modal">
        <div class="relative w-full max-w-4xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ product ? "Edit Product" : 'Create Product' }}
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
                    <form class="mt-8 space-y-6" action="#">
                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="description"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Description</label>
                                <input type="text" id="description"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.description">
                                <InputError class="mt-2" :message="form.errors.description" />

                            </div>
                            <div>
                                <label for="reorder_level"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Reorder
                                    Level</label>
                                <input type="number" id="reorder_level"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.reorder_level">
                                <InputError class="mt-2" :message="form.errors.reorder_level" />

                            </div>
                        </div>
                        <div>
                            <label for="category"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Category</label>
                            <select id="unit_of_measure" v-model="form.product_category_id"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                                <option :value="category.id" v-for="category in categories">{{
                                    category.name
                                }}
                                </option>
                            </select>
                            <InputError class="mt-2" :message="form.errors.product_category_id" />
                        </div>
                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="tax"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tax</label>
                                <select id="tax" v-model="form.tax_id"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                                    <option :value="tax.id" v-for="tax in taxs">{{ tax.name
                                    }}
                                    </option>
                                </select>
                                <InputError class="mt-2" :message="form.errors.tax_id" />
                            </div>
                            <div>
                                <label for="category"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Unit Of
                                    Measure</label>
                                <select id="unit_of_measure" v-model="form.unit_measure_id"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                                    <option :value="unitOfMeasure.id" v-for="unitOfMeasure in unitMeasures">{{
                                        unitOfMeasure.name
                                    }}
                                    </option>
                                </select>
                                <InputError class="mt-2" :message="form.errors.unit_measure_id" />
                            </div>
                        </div>

                        <template v-if="hasMoreThanOnePrices()">
                            <div class="grid gap-6 mb-6 md:grid-cols-3" v-for="(currency, index) in currencies">
                                <div>
                                    <label for="tax"
                                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Retail
                                        Unit Price</label>
                                    <input type="number" name="retail_price" id="retail_price"
                                        class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                        v-model="form.prices[index].retail_price">
                                    <p id="helper-text-explanation"
                                        class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                        {{ currency.name }} : Retail Price
                                    </p>
                                    <!-- <InputError class="mt-2" :message="form.errors.retail_price" /> -->
                                </div>
                                <div>
                                    <label for="category"
                                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Wholesale Unit
                                        Price</label>
                                    <input type="number" name="wholesale_price" id="wholesale_price"
                                        class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                        v-model="form.prices[index].wholesale_price">
                                    <p id="helper-text-explanation"
                                        class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                        {{ currency.name }} : Wholesale Price
                                    </p>
                                    <!-- <InputError class="mt-2" :message="form.errors.wholesale_price" /> -->
                                </div>
                                <div>
                                    <label for="discount"
                                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Discount</label>
                                    <input type="number" name="discount" id="discount"
                                        class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                        v-model="form.prices[index].discount">
                                    <p id="helper-text-explanation"
                                        class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                        {{ currency.name }} : Discount
                                    </p>
                                    <!-- <InputError class="mt-2" :message="form.errors.discount" /> -->
                                </div>
                            </div>
                        </template>
                        <template v-else>
                            <div class="grid gap-6 mb-6 md:grid-cols-3">
                                <div>
                                    <label for="tax"
                                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Retail
                                        Unit Price</label>
                                    <input type="number" name="retail_price" id="retail_price"
                                        class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                        v-model="form.retail_price">
                                    <p id="helper-text-explanation"
                                        class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                        {{ defaultCurrency.name }} : Retail Price
                                    </p>
                                    <InputError class="mt-2" :message="form.errors.retail_price" />
                                </div>
                                <div>
                                    <label for="category"
                                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Wholesale Unit
                                        Price</label>
                                    <input type="number" name="wholesale_price" id="wholesale_price"
                                        class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                        v-model="form.wholesale_price">
                                    <p id="helper-text-explanation"
                                        class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                        {{ defaultCurrency.name }} : Wholesale Price
                                    </p>
                                    <InputError class="mt-2" :message="form.errors.wholesale_price" />
                                </div>
                                <div>
                                    <label for="discount"
                                        class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Discount</label>
                                    <input type="number" name="discount" id="discount"
                                        class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                        v-model="form.discount">
                                    <p id="helper-text-explanation"
                                        class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                        {{ defaultCurrency.name }} : Discount
                                    </p>
                                    <InputError class="mt-2" :message="form.errors.discount" />
                                </div>
                            </div>
                        </template>

                        <div>

                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                for="file_input">Image</label>
                            <input @change="onFileChange"
                                class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400"
                                id="file_input" type="file">
                            <InputError class="mt-2" :message="form.errors.image" />
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

export default {
    components: { InputError },
    props: ['product', 'categories', 'taxs', 'unitMeasures'],
    mounted() {
        this.setMoreprices();
    },
    data() {
        return {
            form: useForm({
                id: this.product?.id || null,
                description: this.product?.description || '',
                reorder_level: this.product?.reorder_level || '',
                product_category_id: this.product?.product_category_id || '',
                tax_id: this.product?.tax_id || '',
                unit_measure_id: this.product?.unit_measure_id || '',
                discount: this.product?.discount || '',
                retail_price: this.product?.retail_price || '',
                wholesale_price: this.product?.wholesale_price || '',
                image: '',
                prices: this.product?.prices || [],
                currency_id: null,
                pricing_method_id: null,
                hasMoreThanOnePrices: false
            }),
            defaultPricingMethod: this.$page.props?.defaultPricingMethod,
            defaultCurrency: this.$page.props?.defaultCurrency,
            currencies: this.$page.props?.currencies,
        }
    },

    methods: {
        submitForm() {
            if (this.product) {
                this.update();
            } else {
                this.create();
            }

        },

        create() {
            this.form.hasMoreThanOnePrices = this.hasMoreThanOnePrices();
            this.form.currency_id = this.defaultCurrency.id;
            this.form.pricing_method_id = this.defaultPricingMethod.id;
            this.form.post('/admin/products', {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },

        update() {
            this.form.hasMoreThanOnePrices = this.hasMoreThanOnePrices();
            this.form.post(`/admin/update-product/${this.product.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },

        //on image change
        onFileChange(e) {
            let files = e.target.files || e.dataTransfer.files;
            if (!files.length)
                return;
            this.form.image = files[0];
        },
        setMoreprices() {
            if (this.hasMoreThanOnePrices()) {
                this.form.prices = this.currencies.map(currency => {
                    return {
                        currency_id: currency.id,
                        retail_price: '',
                        wholesale_price: '',
                        discount: '',
                        is_default: currency.id == this.defaultCurrency.id ? true : false,
                        pricing_method_id: this.defaultPricingMethod.id,
                    }
                })
            }
        },

        hasMoreThanOnePrices() {
            return !this.defaultPricingMethod.name.includes('Exchange Rate');
        },
    },

    watch: {
        // Watch the 'product' prop for changes
        product: {
            handler(newValue) {
                // Update the 'form' data when 'product' prop changes
                this.form.id = newValue?.id || null;
                this.form.description = newValue?.description || '';
                this.form.reorder_level = newValue?.reorder_level || '';
                this.form.product_category_id = newValue?.product_category_id || '';
                this.form.tax_id = newValue?.tax_id || '';
                this.form.unit_measure_id = newValue?.unit_measure_id || '';
                this.form.discount = newValue?.discount || '';
                this.form.retail_price = newValue?.retail_price || '';
                this.form.wholesale_price = newValue?.wholesale_price || '';
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>