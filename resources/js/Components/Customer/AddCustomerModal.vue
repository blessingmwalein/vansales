<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="add-customer-modal">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ customer ? "Edit Customer" : 'Create Customer' }}
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
                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Full
                                    Name</label>
                                <input type="text" id="description"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.name">
                                <InputError class="mt-2" :message="form.errors.name" />

                            </div>
                            <div>
                                <label for="reorder_level"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
                                <input type="email" id="email	"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.email">
                                <InputError class="mt-2" :message="form.errors.email" />

                            </div>
                        </div>
                        <div>
                            <label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone
                                Number</label>
                            <input type="text" name="phone_number" id="phone_number"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                v-model="form.phone_number">
                            <InputError class="mt-2" :message="form.errors.phone_number" />

                        </div>
                        <div>
                            <label for="route"
                                class="block mt-2 mb-2 text-sm font-medium text-gray-900 dark:text-white">Default
                                Route</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="form.route_id" :options="routeOptions" label="name" track-by="id">
                            </multiselect>
                            <InputError class="mt-2" :message="form.errors.route_id" />
                        </div>
                        <div>
                            <label for="tax" class="flex mb-2 mt-2 text-sm font-medium text-gray-900 dark:text-white">
                                Location <span
                                    class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                    Lat: {{ form.lat }} Lng: {{ form.lon }}

                                </span></label>
                            <GMapAutocomplete
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="Search location" @place_changed="setLocation">
                            </GMapAutocomplete>
                        </div>
                        <div>
                            <label for="name"
                                class="block mb-2 mt-2 text-sm font-medium text-gray-900 dark:text-white">Address</label>
                            <textarea id="message" v-model="form.address" rows="4"
                                class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="Customer Address"></textarea>
                            <InputError class="mt-2" :message="form.errors.address" />

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
import Multiselect from 'vue-multiselect'


export default {
    components: { InputError, Multiselect },
    props: ['customer', 'routes'],
    mounted() {
        this.routeOptions = this.routes.map(route => {
            return {
                id: route.id,
                name: route.name,
            }
        })
        if (this.customer) {
            this.form.route_id = this.routeOptions.find(route => route.id == this.customer.route_id);
        }
    },
    data() {
        return {
            form: useForm({
                name: this.customer?.name || '',
                email: this.customer?.email || '',
                phone_number: this.customer?.phone_number || '',
                address: this.customer?.address || '',
                id: this.customer?.id || null,
                route_id: this.customer?.route_id || null,
                lat: this.customer?.lat || null,
                lon: this.customer?.lon || null,
            }),
            routeOptions: [],
        }
    },

    methods: {
        submitForm() {
            if (this.customer) {
                this.update();
            } else {
                this.create();
            }

        },

        create() {
            this.form.route_id = this.form.route_id ? this.form.route_id.id : null;
            this.form.post('/admin/customers', {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },

        update() {
            this.form.route_id = this.form.route_id ? this.form.route_id.id : null;
            this.form.put(`/admin/customers/${this.customer.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },

        setLocation(event) {
            this.form.lat = event.geometry.location.lat();
            this.form.lon = event.geometry.location.lng();
        },
    },

    watch: {
        // Watch the 'customer' prop for changes
        customer: {
            handler(newValue) {
                console.log(newValue);
                // Update the 'form' data when 'customer' prop changes
                this.form.name = newValue?.name || '';
                this.form.id = newValue?.id || null;
                this.form.email = newValue?.email || '';
                this.form.phone_number = newValue?.phone_number || '';
                this.form.address = newValue?.address || '';
                this.form.route_id = this.routeOptions.find(route => route.id == newValue.route_id);
                this.form.lat = newValue?.lat || null;
                this.form.lon = newValue?.lon || null;
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
