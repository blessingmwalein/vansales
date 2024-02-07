<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="add-user-modal">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ user ? "Edit User" : 'Create User' }}
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
                                <label for="first_name"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">First
                                    name</label>
                                <input type="text" id="first_name"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    placeholder="John" v-model="form.first_name">
                                <InputError class="mt-2" :message="form.errors.first_name" />

                            </div>
                            <div>
                                <label for="last_name"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Last
                                    name</label>
                                <input type="text" id="last_name"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    placeholder="Doe" v-model="form.last_name">
                                <InputError class="mt-2" :message="form.errors.last_name" />

                            </div>
                        </div>
                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="email"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone
                                    Number</label>
                                <input type="text" name="phone_number" id="phone_number"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                    v-model="form.phone_number">
                                <InputError class="mt-2" :message="form.errors.phone_number" />
                            </div>
                            <div>
                                <label for="role"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Role</label>

                                <multiselect @select="setIsDriver"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                    v-model="form.role_id" :options="rolesOptions" label="name" track-by="id">
                                </multiselect>
                                <InputError class="mt-2" :message="form.errors.role_id" />
                            </div>
                        </div>

                        <div>
                            <label for="email" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                email</label>
                            <input type="email" name="email" id="email"
                                class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="name@company.com" v-model="form.email">
                            <InputError class="mt-2" :message="form.errors.email" />

                        </div>
                        <div class="grid gap-6 mb-6 md:grid-cols-2" v-if="isDriver">

                            <div v-if="hasSettingActive('Warehouse', settings)">
                                <label for="email"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Default
                                    Warehouse</label>
                                <multiselect
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                    v-model="form.warehouse_id" :options="warehouseOptions" label="name" track-by="id">
                                </multiselect>
                                <InputError class="mt-2" :message="form.errors.warehouse_id" />
                            </div>
                            <div v-if="hasSettingActive('Trucks', settings)">
                                <label for="category"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Default
                                    Truck</label>
                                <multiselect
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                    v-model="form.truck_id" :options="truckOptions" label="name" track-by="id">
                                </multiselect>
                                <InputError class="mt-2" :message="form.errors.truck_id" />
                            </div>
                        </div>
                        <div v-if="hasSettingActive('Routes', settings) && isDriver">
                            <label for="route" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Default
                                Route</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="form.route_id" :options="routeOptions" label="name" track-by="id">
                            </multiselect>
                            <InputError class="mt-2" :message="form.errors.route_id" />
                        </div>

                        <div>
                            <label for="route"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Address</label>
                            <textarea id="description" rows="4" v-model="form.address"
                                class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="User address"></textarea>

                            <InputError class="mt-2" :message="form.errors.address" />
                        </div>
                        <div class="grid gap-6 mb-6 md:grid-cols-2">

                            <div>
                                <label for="password"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    password</label>
                                <input type="password" name="password" id="password" placeholder="••••••••"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                    v-model="form.password">
                                <InputError class="mt-2" :message="form.errors.password" />

                            </div>
                            <div>
                                <label for="confirm-password"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Confirm
                                    password</label>
                                <input type="password" name="confirm-password" id="confirm-password" placeholder="••••••••"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                    v-model="form.password_confirmation">
                                <InputError class="mt-2" :message="form.errors.password_confirmation" />

                            </div>
                        </div>
                        <div>
                            <label class="relative inline-flex items-center mb-4 mt-8 cursor-pointer">
                                <input type="checkbox" value="" class="sr-only peer" checked v-model="form.is_available">
                                <div
                                    class="w-11 h-6 bg-gray-200 rounded-full peer peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600">
                                </div>
                                <span class="ml-3 text-sm font-medium text-gray-900 dark:text-gray-300">Is
                                    Available</span>
                            </label>
                            <InputError class="mt-2" :message="form.errors.is_available" />

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
import globalMixin from "@/Mixins/global.js";


export default {
    components: { InputError, Multiselect },
    props: ['user', 'roles', 'settings', 'warehouses', 'trucks', 'routes'],
    mixins: [globalMixin],
    mounted() {
        this.updateOptions();
    },
    data() {
        return {
            form: useForm({
                first_name: '',
                last_name: '',
                phone_number: '',
                email: '',
                password: '',
                password_confirmation: '',
                warehouse_id: null,
                truck_id: null,
                route_id: null,
                role_id: null,
                is_available: null,
                address: '',
            }),
            truckOptions: [],
            warehouseOptions: [],
            routeOptions: [],
            rolesOptions: [],
            isDriver: false,
        }
    },

    methods: {
        updateOptions() {
            this.rolesOptions = this.roles.map(role => {
                return {
                    id: role.id,
                    name: role.name,
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
                    name: `${warehouse.code} - ${warehouse.name}`, // `first` and `second` are the column names in the table
                }
            })

            this.routeOptions = this.routes.map(route => {
                return {
                    id: route.id,
                    name: route.name,
                }
            })
        },
        submitForm() {
            if (this.user) {
                this.update();
            } else {
                this.create();
            }
        },

        create() {
            this.form.role_id = this.form.role_id?.id ?? null;
            this.form.warehouse_id = this.form.warehouse_id?.id ?? null;
            this.form.truck_id = this.form.truck_id?.id ?? null;
            this.form.route_id = this.form.route_id?.id ?? null;
            this.form.post('/admin/users', {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset();
                    this.$emit('save');
                }
            });
        },

        update() {
            this.form.role_id = this.form.role_id?.id ?? null;
            this.form.warehouse_id = this.form.warehouse_id?.id ?? null;
            this.form.truck_id = this.form.truck_id?.id ?? null;
            this.form.route_id = this.form.route_id?.id ?? null;
            this.form.put(`/admin/users/${this.user.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset();
                    this.$emit('save');
                }
            });
        },

        setIsDriver() {
            this.isDriver = this.form.role_id.name == 'salesman' ? true : false;
        }
    },

    watch: {
        // Watch the 'user' prop for changes
        user: {
            handler(newValue) {
                // Update the 'form' data when 'user' prop changes
                this.form.first_name = newValue?.first_name ?? '';
                this.form.last_name = newValue?.last_name ?? '';
                this.form.phone_number = newValue?.phone_number ?? '';
                this.form.email = newValue?.email ?? '';
                this.form.id = newValue?.id ?? null;
                this.form.role_id = newValue?.roles[0].id ?? null;
                this.form.is_available = newValue?.is_available == 1 ? true : false ?? '';

            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
