<template>
    <div class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full"
        id="add-route-modal">
        <div class="relative w-full max-w-4xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-gray-800">
                <!-- Modal header -->
                <div class="flex items-start justify-between p-5 border-b rounded-t dark:border-gray-700">
                    <h3 class="text-xl font-semibold dark:text-white">
                        {{ route ? "Edit Route" : 'Create Route' }}
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
                    <form class="space-y-6" action="#">
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
                                <label for="number_centers"
                                    class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Number of
                                    Centers</label>
                                <input type="number" id="number_centers" @change="updateNumberCenters"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.number_centers">
                                <InputError class="mt-2" :message="form.errors.number_centers" />

                            </div>
                        </div>

                        <div>
                            <label for="tax" class="flex mb-2 text-sm font-medium text-gray-900 dark:text-white">Start
                                Location <span
                                    class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                    Lat: {{ form.start_lat }} Lng: {{ form.start_lon }}

                                </span></label>
                            <!-- <input type="number" id="number_centers"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="form.start_lat"> -->
                            <GMapAutocomplete
                                class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                placeholder="Search location" @place_changed="setStartLocation">
                            </GMapAutocomplete>
                        </div>
                        <div>
                            <h5 class="text-xl font-bold dark:text-white">Route Nodes</h5>
                        </div>
                        <div class="grid gap-6 mb-6 md:grid-cols-2 mb-4" v-for="(node, index) in form.nodes" :key="index">
                            <div>
                                <label for="tax" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                    Name</label>
                                <input type="text" id="number_centers"
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    v-model="node.name">

                            </div>
                            <div>
                                <label for="tax" class="flex mb-2 text-sm font-medium text-gray-900 dark:text-white">
                                    Location <span
                                        class="flex bg-blue-100 text-blue-800 text-xs font-medium mr-2 px-3 py-1 rounded-full dark:bg-blue-900 dark:text-blue-300 ">
                                        Lat: {{ node.lat }} Lng: {{ node.lon }}

                                    </span></label>
                                <GMapAutocomplete
                                    class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                                    placeholder="Search location" @place_changed="setNodeLocation($event, node)">
                                </GMapAutocomplete>

                            </div>

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
    props: ['route'],
    mounted() {


    },
    data() {
        return {
            form: useForm({
                id: this.route?.id || null,
                name: this.route?.name || '',
                number_centers: this.route?.number_centers || '',
                start_lat: this.route?.start_lat || '',
                start_lon: this.route?.start_lon || '',
                nodes: this.route?.nodes || [],
            })
        }
    },

    methods: {
        submitForm() {
            if (this.route) {
                this.update();
            } else {
                this.create();
            }

        },

        create() {
            this.form.post('/company/routes', {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },
        setStartLocation(event) {
            console.log(event)
            this.form.name = event.name;
            this.form.start_lat = event.geometry.location.lat();
            this.form.start_lon = event.geometry.location.lng();

        },

        update() {
            this.form.post(`/company/routes/${this.route.id}`, {
                preserveScroll: true,
                onSuccess: () => {
                    this.$emit('save');
                }
            });
        },

        updateNumberCenters() {
            this.form.nodes = [];
            for (let i = 0; i < this.form.number_centers; i++) {
                this.form.nodes.push({
                    id: i + 1,
                    name: '',
                    lat: '',
                    lon: '',
                });
            }
        },
        //on image change
        setNodeLocation(event, node) {
            //find node to be updated by id
            let index = this.form.nodes.findIndex(x => x.id === node.id);
            //update node
            this.form.nodes[index].lat = event.geometry.location.lat();
            this.form.nodes[index].lon = event.geometry.location.lng();
            this.form.nodes[index].name = event.name;

        }

    },

    watch: {
        // Watch the 'route' prop for changes
        route: {
            handler(newValue) {
                // Update the 'form' data when 'route' prop changes
                this.form.id = newValue?.id || null;
                this.form.name = newValue?.name || '';
                this.form.number_centers = newValue?.number_centers || '';
                this.form.start_lat = newValue?.start_lat || '';
                this.form.start_lon = newValue?.start_lon || '';
                this.form.nodes = newValue?.nodes || [];
            },
            immediate: true, // This ensures the watcher runs immediately when the component is mounted
        },
    },
}
</script>
