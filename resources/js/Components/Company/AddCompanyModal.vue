<template>
    <div class="fixed left-0 right-0 z-50 items-center justify-center hidden overflow-x-hidden overflow-y-auto top-4 md:inset-0 h-modal sm:h-full"
        id="add-company-modal">
        <div class="relative w-full h-full max-w-2xl px-4 md:h-auto">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ company ? "Edit Company" : 'Create Company' }}
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

                    <div v-if="step === 1">
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
                                <input type="text" id="email"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.companyEmail">
                                <InputError class="mt-2" :message="form.errors.companyEmail" />

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
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Bpn</label>
                            <input type="text" id="phone"
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                v-model="form.bpn">
                            <InputError class="mt-2" :message="form.errors.bpn" />
                        </div>
                        <div>
                            <label for="route" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Company
                                Address</label>
                            <textarea id="description" rows="4" v-model="form.companyAddress"
                                class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="Company address"></textarea>

                            <InputError class="mt-2" :message="form.errors.companyAddress" />
                        </div>

                        <div class="flex justify-end mt-2">
                            <button
                                class=" px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
                                v-if="step > 1" @click="prevStep">

                                <i class="bi bi-arrow-left-circle"></i>Previous</button>
                            <button
                                class=" px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
                                @click="submitForm">
                                Next <i class="bi bi-arrow-right-circle"></i>

                            </button>
                        </div>

                    </div>
                    <div v-else-if="step === 2">
                        <label for="first_name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Default
                            User</label>

                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">First
                                    Name</label>
                                <input type="text" id="first_name"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.first_name">
                                <InputError class="mt-2" :message="form.errors.first_name" />

                            </div>
                            <div>
                                <label for="lastname"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Last
                                    Name</label>
                                <input type="text" id="last_name"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.last_name">
                                <InputError class="mt-2" :message="form.errors.last_name" />

                            </div>
                        </div>
                        <div>
                            <label for="route" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">User
                                Address</label>
                            <textarea id="description" rows="4" v-model="form.address"
                                class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
                                placeholder="User address"></textarea>

                            <InputError class="mt-2" :message="form.errors.address" />
                        </div>

                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="name" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Phone
                                    Number</label>
                                <input type="text" id="phone_number"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.phone_number">
                                <InputError class="mt-2" :message="form.errors.phone_number" />

                            </div>
                            <div>
                                <label for="lastname"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
                                <input type="text" id="email"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.email">
                                <InputError class="mt-2" :message="form.errors.email" />
                            </div>
                        </div>

                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="name"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Password</label>
                                <input type="password" id="password"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.password">
                                <InputError class="mt-2" :message="form.errors.password" />

                            </div>
                            <div>
                                <label for="lastname"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Confirm
                                    Password</label>
                                <input type="password" id="password_confirmation"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.password_confirmation">
                                <InputError class="mt-2" :message="form.errors.password_confirmation" />
                            </div>
                        </div>
                        <div class="grid gap-6 mb-6 md:grid-cols-2">
                            <div>
                                <label for="brand" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">User
                                    Type</label>
                                <multiselect
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                    v-model="form.type" :options="userTypeOptions" :multiple="false" label="type"
                                    track-by="id">
                                </multiselect>
                                <InputError class="mt-2" :message="form.errors.type" />

                            </div>
                            <div>
                                <label for="brand" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">User
                                    Role</label>
                                <multiselect
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                    v-model="form.role_id" :options="rolesOptions" :multiple="false" label="name"
                                    track-by="id">
                                </multiselect>
                                <InputError class="mt-2" :message="form.errors.role_id" />

                            </div>
                        </div>


                        <div class="flex justify-between">
                            <button @click="prevStep"
                                className="px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"><i
                                    class="bi bi-arrow-left-circle"></i>
                                Previous</button>
                            <button
                                className="px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
                                @click="submitForm">Next
                                <i class="bi bi-arrow-right-circle"></i>
                            </button>
                        </div>


                    </div>
                    <div v-else-if="step === 3">
                        <label for="first_name"
                            class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Subscription
                            Details</label>

                        <div>
                            <label for="route" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Choose
                                Package</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="form.subscription_id" :options="subscriptionOptions" :multiple="false" label="name"
                                track-by="id">
                            </multiselect>
                            <InputError class="mt-2" :message="form.errors.subscription_id" />
                        </div>

                        <div>
                            <label for="route"
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Period</label>
                            <multiselect
                                class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
                                v-model="form.period" :options="periodOptions" :multiple="false" label="name" track-by="id">
                            </multiselect>
                            <InputError class="mt-2" :message="form.errors.period" />
                        </div>



                        <div class="flex justify-between">
                            <button @click="prevStep"
                                className="px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"><i
                                    class="bi bi-arrow-left-circle"></i>
                                Previous</button>
                            <button @click="submitForm"
                                className="px-5 py-3 text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Create
                                <i class="bi bi-arrow-right-circle"></i>
                            </button>
                        </div>

                    </div>
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
                first_name: '',
                last_name: '',
                phone: this.company?.phone || '',
                city: this.company?.city || '',
                description: this.company?.description || '',
                phone_number: '',
                email: '',
                companyEmail: this.company?.companyEmail || '',
                bpn: this.company?.bpn || '',
                password: '',
                password_confirmation: '',
                role_id: null,
                address: '',
                companyAddress: this.company?.companyAddress || '',
                period: this.periodOptions?.find(period => period.name === this.company?.subscription?.period) || '',
                subscription_id: this.subscriptionOptions?.find(subscription => subscription.id === this.company?.subscription?.subscription?.id) || '',
                type: '',
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

        nextStep() {
            // submit and stop if we have validation error

            if (this.step < 3) {
                this.step++;
            }
        },
        prevStep() {
            if (this.step > 1) {
                this.step--;
            }
        },
        // submitForm() {
        //     if (this.company) {
        //         this.update();
        //     } else {
        //         this.create();
        //     }
        // },

        create() {
            this.form.post('/admin/companies', {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset();
                    this.$emit('save');
                }
            });
        },

        //check if companyForm has errors for that particular step
        hasErrors(step) {
            if (step === 1) {
                return this.form.errors.name || this.form.errors.companyEmail || this.form.errors.description || this.form.errors.phone || this.form.errors.city || this.form.errors.bpn || this.form.errors.companyAddress;
            } else if (step === 2) {
                return this.form.errors.first_name || this.form.errors.last_name || this.form.errors.phone_number || this.form.errors.email || this.form.errors.password || this.form.errors.role_id || this.form.errors.type;
            } else if (step === 3) {
                return this.form.errors.subscription_id || this.form.errors.period;
            }
        },

        async submitForm() {
            // Step 1: Company details form

            //clear errors
            this.form.errors = {};
            this.form.role_id = this.form.role_id?.id ?? null;
            this.form.subscription_id = this.form.subscription_id?.id ?? null;
            this.form.period = this.form.period?.name ?? null;
            this.form.type = this.form.type?.type ?? null;

            if (this.step === 1) {
                await this.submitCompanyDetails();
            }

            // Step 2: Default user details form
            else if (this.step === 2) {
                await this.submitDefaultUserDetails();
            }

            // Step 3: Subscription form
            else if (this.step === 3) {
                await this.submitSubscriptionDetails();
            }
        },

        async submitCompanyDetails() {
            // Submit company details form
            await this.form.post('/admin/companies', {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset();
                    this.$emit('save');
                },
                onFinish: () => {
                    if (this.hasErrors(this.step)) {
                        // If there are errors, do not proceed to the next step
                        return;
                    }

                    this.form.role_id = this.rolesOptions.find(role => role.id === this.form.role_id);
                    this.form.type = this.userTypeOptions.find(type => type.type === this.form.type);
                    this.form.subscription_id = this.subscriptionOptions.find(subscription => subscription.id === this.form.subscription_id);
                    this.form.period = this.periodOptions.find(period => period.name === this.form.period);
                    // Proceed to the next step
                    this.nextStep();
                }
            }
            )

        },

        async submitDefaultUserDetails() {
            // Submit default user details form
            await this.form.post('/admin/companies', {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset();
                    this.$emit('save');
                },
                onFinish: () => {
                    if (this.hasErrors(this.step)) {
                        // If there are errors, do not proceed to the next step
                        return;
                    }

                    //map back role and type selected object
                    this.form.role_id = this.rolesOptions.find(role => role.id === this.form.role_id);
                    this.form.type = this.userTypeOptions.find(type => type.type === this.form.type);
                    this.form.subscription_id = this.subscriptionOptions.find(subscription => subscription.id === this.form.subscription_id);
                    this.form.period = this.periodOptions.find(period => period.name === this.form.period);            // Proceed to the next step

                    this.nextStep();
                }
            })
            // console.log(this.hasErrors(this.step))
            // console.log(this.form.errors)
            // console.log(this.step)

            // Check for errors

        },

        async submitSubscriptionDetails() {
            // Submit subscription details form
            await this.form.post('/admin/companies', {
                preserveScroll: true,
                onSuccess: () => {
                    this.form.reset();
                    this.$emit('save');
                },
                onFinish: () => {
                    if (this.hasErrors(this.step)) {
                        // If there are errors, do not proceed to the next step
                        return;
                    }

                    this.form.role_id = this.rolesOptions.find(role => role.id === this.form.role_id);
                    this.form.type = this.userTypeOptions.find(type => type.type === this.form.type);
                    this.form.subscription_id = this.subscriptionOptions.find(subscription => subscription.id === this.form.subscription_id);
                    this.form.period = this.periodOptions.find(period => period.name === this.form.period);
                    // Proceed to the next step or finalize the submission
                    this.nextStep();
                }
            })

            // Check for errors

        },

        update() {
            this.form.role_id = this.form.role_id?.id ?? null;
            this.form.subscription_id = this.form.subscription_id?.id ?? null;
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
                this.form.companyEmail = newValue?.email ?? '';
                this.form.id = newValue?.id ?? null;
                this.form.name = newValue?.name ?? '';
                this.form.description = newValue?.description ?? '';
                this.form.city = newValue?.city ?? '';
                this.form.bpn = newValue?.bpn ?? '';
                this.form.companyAddress = newValue?.address ?? '';
                this.form.subscription_id = newValue?.subscription?.id ?? null;
                this.form.period = newValue?.subscription?.period ?? null;

            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
