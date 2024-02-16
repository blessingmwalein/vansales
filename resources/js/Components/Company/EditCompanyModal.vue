<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="edit-company-modal">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ "Edit Company" }}
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

                    <form>
                        <!-- Company details form -->

                        <label for="first_name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Company
                            Details</label>

                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="name"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Name</label>
                                <input type="text" id="name"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.name">
                                <InputError class="mt-2" :message="form.errors.name" />

                            </div>
                            <div>
                                <label for="email"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Company
                                    Email</label>
                                <input type="text" id="email" disabled
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.email">
                                <InputError class="mt-2" :message="form.errors.email" />

                            </div>
                        </div>

                        <div>
                            <label for="route"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Description</label>
                            <textarea id="description" rows="4" v-model="form.description"
                                class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="Company description"></textarea>

                            <InputError class="mt-2" :message="form.errors.description" />
                        </div>
                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone
                                    Number</label>
                                <input type="number" id="phone"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.phone">
                                <InputError class="mt-2" :message="form.errors.phone" />

                            </div>
                            <div>
                                <label for="city"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">City</label>
                                <input type="text" id="city"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.city">
                                <InputError class="mt-2" :message="form.errors.city" />

                            </div>
                        </div>
                        <div>
                            <label for="route"
                                class="block mb-2 mt-2 text-sm font-medium text-gray-900 dark:text-white">Bpn</label>
                            <input type="text" id="phone"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                v-model="form.bpn">
                            <InputError class="mt-2" :message="form.errors.bpn" />
                        </div>
                        <div>
                            <label for="route"
                                class="block mb-2 mt-2 text-sm font-medium text-gray-900 dark:text-white">Company
                                Address</label>
                            <textarea id="description" rows="4" v-model="form.address"
                                class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="Company address"></textarea>

                            <InputError class="mt-2" :message="form.errors.address" />
                        </div>

                        <label for="first_name"
                            class="block mt-2 text-xl font-semibold text-gray-900 dark:text-white">Subscription
                            Details</label>

                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="route"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Choose
                                    Package</label>
                                <multiselect
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                    v-model="form.subscription_id" :options="subscriptionOptions" :multiple="false"
                                    label="name" track-by="id">
                                </multiselect>
                                <InputError class="mt-2" :message="form.errors.subscription_id" />
                            </div>

                            <div>
                                <label for="route"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Period</label>
                                <multiselect
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                    v-model="form.period" :options="periodOptions" :multiple="false" label="name"
                                    track-by="id">
                                </multiselect>
                                <InputError class="mt-2" :message="form.errors.period" />
                            </div>
                        </div>

                        <div class="flex justify-end">

                            <button
                                class=" px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
                                @click.prevent="submitForm">
                                Save

                            </button>
                        </div>

                    </form>


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
    components: { InputError, Multiselect },
    props: ['company', 'roles', 'subscriptions'],
    mixins: [globalMixin],
    mounted() {
        this.updateOptions();

    },
    data() {
        return {
            form: useForm({
                name: this.company?.name || '',
                phone: this.company?.phone || '',
                city: this.company?.city || '',
                description: this.company?.description || '',
                email: this.company?.email || '',
                bpn: this.company?.bpn || '',
                address: this.company?.address || '',
                period: this.periodOptions?.find(period => period.name === this.company?.subscription?.period) || '',
                subscription_id: ''
            }),
            subscriptionOptions: [],
            rolesOptions: [],
            step: 1,
            periodOptions: [
                { id: 1, name: 'Monthly' },
                { id: 2, name: 'Yearly' },
                { id: 3, name: 'Quarterly' }
            ],
            userTypeOptions: [
                { id: 1, type: 'External' },
                { id: 2, type: 'Internal' },
            ],
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

            this.subscriptionOptions = this.subscriptions.map(subscription => {
                return {
                    id: subscription.id,
                    name: `${subscription.name}`,
                }
            })
        },

        submitForm() {
            this.form.subscription_id = this.form?.subscription_id?.id ?? null;
            this.form.period = this.form.period?.name ?? null;
            this.form.put(`/admin/companies/${this.company.id}`, {
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
                // Update the 'form' data when 'company' prop changes

                this.form.phone = newValue?.phone ?? '';
                this.form.email = newValue?.email ?? '';
                this.form.id = newValue?.id ?? null;
                this.form.name = newValue?.name ?? '';
                this.form.description = newValue?.description ?? '';
                this.form.city = newValue?.city ?? '';
                this.form.bpn = newValue?.bpn ?? '';
                this.form.address = newValue?.address ?? '';
                this.form.subscription_id = this.subscriptionOptions.find(sub => sub.id == newValue?.subscription_id) ?? null;
                this.form.period = this.periodOptions.find(period => period?.name == newValue?.subscription_period) ?? null;

            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
