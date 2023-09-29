<template>
    <div id="upload-excel-product" tabindex="-1"
        class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
        <div class="relative w-full max-w-7xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-5 border-b rounded-t dark:border-gray-600">
                    <h3 class="text-xl font-medium text-gray-900 dark:text-white">
                        Upload Excel Products
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

                    <div class="flex items-center justify-center w-full" v-if="products.length <= 0">
                        <label for="dropzone-file"
                            class="flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600">
                            <div class="flex flex-col items-center justify-center pt-5 pb-6">
                                <svg class="w-8 h-8 mb-4 text-gray-500 dark:text-gray-400" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 16">
                                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2" />
                                </svg>
                                <p class="mb-2 text-sm text-gray-500 dark:text-gray-400"><span class="font-semibold">Click
                                        to upload</span> or drag and drop</p>
                                <p class="text-xs text-gray-500 dark:text-gray-400">SVG, PNG, JPG or GIF (MAX. 800x400px)
                                </p>
                            </div>
                            <input id="dropzone-file" type="file" class="hidden" @change="filechange" />
                        </label>
                    </div>
                    <div class="flex flex-col" v-else>
                        <div class="overflow-x-auto">
                            <div class="inline-block min-w-full align-middle">
                                <div class="overflow-hidden shadow">
                                    <TableLayout :hasData="products.length > 0 ? true : false">
                                        <template v-slot:table>
                                            <table
                                                class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
                                                <thead class="bg-gray-100 dark:bg-gray-700">
                                                    <tr>

                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Product Name
                                                        </th>
                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Unit Measure
                                                        </th>
                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Tax
                                                        </th>

                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Category
                                                        </th>

                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Retail Price
                                                        </th>

                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Discount
                                                        </th>
                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Wholesale
                                                        </th>
                                                        <th scope="col"
                                                            class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
                                                            Reorder Level
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody
                                                    class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">

                                                    <tr class="hover:bg-gray-100 dark:hover:bg-gray-700"
                                                        v-for="product in products">

                                                        <td class="flex items-center p-4 mr-12 space-x-6 whitespace-nowrap">

                                                            <div
                                                                class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                                                <div
                                                                    class="text-base font-semibold text-gray-900 dark:text-white">
                                                                    {{ product[0] }}</div>


                                                            </div>
                                                        </td>
                                                        <td
                                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                            {{ product[3] }}</td>
                                                        <td
                                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                            {{ product[2] }}</td>


                                                        <td
                                                            class=" p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                            {{ product[1] }}
                                                        </td>
                                                        <td
                                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                            ${{ product[4] }}
                                                        </td>
                                                        <td
                                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                            ${{ product[5] }}
                                                        </td>
                                                        <td
                                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                            ${{ product[6] }}
                                                        </td>
                                                        <td
                                                            class="p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                                            ${{ product[7] }}
                                                        </td>


                                                    </tr>


                                                </tbody>
                                            </table>
                                        </template>
                                        <template v-slot:action-button>
                                            <button @click="openAddProductModal()"
                                                class="flex items-center justify-center w-1/2 px-5 py-2 text-sm tracking-wide text-white transition-colors duration-200 bg-blue-500 rounded-lg shrink-0 sm:w-auto gap-x-2 hover:bg-blue-600 dark:hover:bg-blue-500 dark:bg-blue-600">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                                    stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                                                    <path stroke-linecap="round" stroke-linejoin="round"
                                                        d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                </svg>

                                                <span>Add Product</span>
                                            </button>
                                        </template>
                                    </TableLayout>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- Modal footer -->
                <div class="flex items-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600">
                    <button type="button" @click="submitForm(false)" v-if="products.length <= 0"
                        class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Preview</button>
                    <button v-else type="button" @click="saveFile()"
                        class="text-gray-500 bg-white hover:bg-gray-100 focus:ring-4 focus:outline-none focus:ring-gray-200 rounded-lg border border-gray-200 text-sm font-medium px-5 py-2.5 hover:text-gray-900 focus:z-10 dark:bg-gray-700 dark:text-gray-300 dark:border-gray-500 dark:hover:text-white dark:hover:bg-gray-600 dark:focus:ring-gray-600">Save</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import InputError from '@/Components/InputError.vue';
import { useForm } from '@inertiajs/vue3';
import globalMixin from "@/Mixins/global.js";
import axios from 'axios';
import TableLayout from '@/Components/TableLayout.vue';

export default {
    components: { InputError, TableLayout },
    props: [],
    mounted() {


    },
    mixins: [globalMixin],
    data() {
        return {
            products: [],
            form: useForm({
                products_template: null,
            }),
            isSave: false,
        }
    },

    methods: {
        submitForm(isSave) {
            //submit with axios
            var formData = new FormData();
            formData.append("products_template", this.file);
            formData.append('isSave', isSave);

            axios.post('/admin/upload-excel-products', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then((response) => {

                if (!isSave) {
                    this.products = response.data[0];
                }
            }).catch((error) => {
                //error
                this.fireSnackbar(error.response.data.message, "Copied", '#FF0000', "success");
            });
        },
        saveFile() {
            console.log(this.form.products_template);
            this.form.post('/admin/save-excel-products', {
                preserveScroll: true,
                onSuccess: () => {
                    this.file = null;
                    this.form.reset();
                    this.$emit('close');
                },
            });
        },
        filechange(e) {
            // Check if a file is selected
            let files = e.target.files || e.dataTransfer.files;
            if (!files.length) {
                return;
            }

            // Get the selected file


            // Check if the file type is Excel (xls or xlsx)
            if (this.isExcelFile(files[0])) {
                this.file = files[0];
                this.form.products_template = files[0];
            } else {
                this.fireSnackbar("Please select excel file", "Copied", '#FF0000', "success");
            }
        },
        save() {
            var formData = new FormData();

            formData.append("products_template", this.file);
            axios.post('/admin/save-excel-products', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }).then((response) => {
                this.fireSnackbar(response.data.message, "Copied", '##00FF00', "success");
                this.file = null;
            }).catch((error) => {
                //error
                this.fireSnackbar(error.response.data.message, "Copied", '#FF0000', "success");
            });
        },


        isExcelFile(file) {
            const allowedExtensions = ["xls", "xlsx"];
            const fileName = file.name;
            const fileExtension = fileName.split(".").pop().toLowerCase();

            return allowedExtensions.includes(fileExtension);
        }

    },


}
</script>