<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="add-deliverySheet-modal">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ deliverySheet ? "Edit Delivery Sheet" : 'Create Delivery Sheet' }}
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
                                <label for="user"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Available
                                    Drivers</label>
                                <multiselect @select="setDefaultSettings"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                    v-model="form.user_id" :options="userOptions" placeholder="Select Driver" label="name"
                                    value="user_id"></multiselect>
                                <p v-if="deliverySheet" id="helper-text-explanation"
                                    class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                    Current Driver : {{ deliverySheet?.user.first_name }} {{ deliverySheet?.user.last_name
                                    }}
                                </p>
                                <InputError class="mt-2" :message="form.errors.user_id" />

                            </div>
                            <div>
                                <label for="truck_id"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Avaible
                                    Trucks</label>
                                <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                    v-model="form.truck_id" :options="truckOptions" placeholder="Select Truck" label="name"
                                    track-by="name"></multiselect>
                                <p v-if="deliverySheet" id="helper-text-explanation"
                                    class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                    Current Truck : {{ deliverySheet?.truck.make_model }} {{
                                        deliverySheet?.truck.license_plate }}
                                </p>
                                <InputError class="mt-2" :message="form.errors.truck_id" />
                            </div>
                        </div>

                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="tax"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Route</label>
                                <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                    v-model="form.route_id" :options="routeOptions" placeholder="Select Route" label="name"
                                    track-by="name"></multiselect>
                                <!-- <p v-if="deliverySheet" id="helper-text-explanation"
                                    class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                    Current Route : {{ deliverySheet?.route.name }}
                                </p> -->

                                <InputError class="mt-2" :message="form.errors.route_id" />
                            </div>
                            <div>
                                <label for="category"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Warehouse</label>
                                <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                                    v-model="form.warehouse_id" :options="warehouseOptions" placeholder="Select one"
                                    label="name" track-by="name"></multiselect>
                                <!-- <p v-if="deliverySheet" id="helper-text-explanation"
                                    class="mt-2 text-sm font-semibold text-gray-600 dark:text-gray-400">
                                    Current Route : {{ deliverySheet?.warehouse.name }}
                                </p> -->
                                <InputError class="mt-2" :message="form.errors.warehouse_id" />
                            </div>
                        </div>
                        <div>
                            <label for="start_date_time"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Depart Date &
                                Time</label>
                            <Datepicker v-model="form.start_date_time" />
                            <InputError class="mt-2" :message="form.errors.start_date_time" />

                        </div>


                    </form>
                </div>
                <!-- Modal footer -->
                <div class="items-center p-6 border-t border-gray-200 rounded-b dark:border-gray-700">
                    <button type="submit" @click="submitForm()" :class="{ 'opacity-25': form.processing }"
                        :disabled="form.processing"
                        class=" px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
                        {{ deliverySheet ? 'Update' : 'Create' }}</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import InputError from '@/Components/InputError.vue';
import { useForm } from '@inertiajs/vue3';
import Multiselect from 'vue-multiselect'
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import globalMixin from "@/Mixins/global.js";

export default {
    components: { InputError, Multiselect, Datepicker },
    props: ['warehouses', 'trucks', 'routes', 'users', 'deliverySheet', 'settings'],
    mixins: [globalMixin],
    mounted() {
        this.updateOptions()
        this.form.company_id = this.clientUser?.company_id
    },
    data() {
        return {
            form: useForm({
                id: this.deliverySheet?.id || null,
                user_id: this.deliverySheet?.user_id || '',
                truck_id: this.deliverySheet?.truck_id || '',
                warehouse_id: this.deliverySheet?.warehouse_id || '',
                route_id: this.deliverySheet?.route_id || '',
                start_date_time: this.deliverySheet?.start_date_time || '',
                manual_allocate: false,
                company_id: null,
            }),
            userOptions: [],
            truckOptions: [],
            warehouseOptions: [],
            routeOptions: [],
        }
    },

    methods: {
        submitForm() {
            if (this.deliverySheet) {
                this.update();
            } else {
                this.create();
            }
        },
        updateOptions() {
            this.userOptions = this.users.map(user => {
                return {
                    id: user.id,
                    name: `${user.first_name} - ${user.last_name}`,
                    value: user.id,
                }
            })

            this.truckOptions = this.trucks.map(truck => {
                return {
                    id: truck.id,
                    name: `${truck.make_model} - ${truck.license_plate}`,
                }
            })

            this.warehouseOptions = this.warehouses.map(warehouse => {
                return {
                    id: warehouse.id,
                    name: `${warehouse.name}`,
                }
            })

            this.routeOptions = this.routes.map(route => {
                return {
                    id: route.id,
                    name: `${route.name}`,
                }
            })
        },

        create() {
            //map form data to match the api endpoint
            this.form.user_id = this.form.user_id.id
            this.form.truck_id = this.form.truck_id.id
            this.form.warehouse_id = this.form.warehouse_id.id
            this.form.route_id = this.form.route_id.id
            this.form.post('/company/deliveries', {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset()
                    this.$emit('save');
                }
            });
        },

        update() {
            this.form.warehouse_id = this.deliverySheet.warehouse.id
            this.form.route_id = this.form.route_id ? this.form.route_id.id : this.deliverySheet.route.id
            this.form.user_id = this.form.user_id ? this.form.user_id.id : this.deliverySheet.user.id
            this.form.truck_id = this.form.truck_id ? this.form.truck_id.id : this.deliverySheet.truck.id
            this.form.put(`/company/deliveries/${this.deliverySheet.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },
        returnFormatedName({ first, second }) {
            return `${first} — ${second}`
        },

        setDefaultSettings() {
            //get the  selected user from users list
            const selectedUser = this.users.find(user => {
                return user.id == this.form.user_id.id
            })

            console.log(selectedUser)
            if (this.hasSettingActive('Warehouse', this.settings)) {
                //find the option that matches the setting
                this.form.warehouse_id = this.warehouseOptions.find(warehouse => {
                    return warehouse.id == selectedUser.warehouse_id
                })

                console.log(this.form.warehouse_id)
            }

            if (this.hasSettingActive('Trucks', this.settings)) {
                //find the option that matches the setting
                this.form.truck_id = this.truckOptions.find(truck => {
                    return truck.id == selectedUser.truck_id
                })

                console.log(this.form.truck_id)

            }

            if (this.hasSettingActive('Routes', this.settings)) {
                //find the option that matches the setting
                this.form.route_id = this.routeOptions.find(route => {
                    return route.id == selectedUser.route_id
                })

                console.log(this.form.route_id)
            }
        }
    },

    watch: {
        // Watch the 'deliverySheet' prop for changes
        deliverySheet: {
            handler(newValue) {
                this.updateOptions()
                // Update the 'form' data when 'deliverySheet' prop changes
                this.form.id = newValue?.id || null;
                this.form.user_id = newValue ? this.userOptions.find(user => user.id == newValue.user.id) : '';
                this.form.truck_id = newValue ? this.truckOptions.find(truck => truck.id == newValue?.truck?.id) : '';
                this.form.warehouse_id = newValue ? this.warehouseOptions.find(warehouse => warehouse.id == newValue?.warehouse?.id) : '';
                this.form.route_id = newValue ? this.routeOptions.find(route => route.id == newValue?.route?.id) : '';
                this.form.start_date_time = newValue?.start_date_time || '';
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
