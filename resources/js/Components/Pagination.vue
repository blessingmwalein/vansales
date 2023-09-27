<template>
    <div class="flex items-center mb-4 sm:mb-0">

        <span class="text-sm font-normal text-gray-500 dark:text-gray-400">Showing <span
                class="font-semibold text-gray-900 dark:text-white">{{ from }}-{{ to }}</span> of <span
                class="font-semibold text-gray-900 dark:text-white">{{ total }}</span></span>
    </div>
    <div class="flex items-center space-x-3">
        <Link :href="prev_page_url" v-if="prev_page_url"
            class="inline-flex items-center justify-center flex-1 px-3 py-2 text-sm font-medium text-center text-white text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
        <svg class="w-5 h-5 mr-1 -ml-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd"
                d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                clip-rule="evenodd"></path>
        </svg>
        Previous
        </Link>
        <Link :href="next_page_url" v-if="next_page_url" class=" inline-flex items-center justify-center flex-1 px-3 py-2 text-sm font-medium text-center text-white
            text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5
            py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">
        Next
        <svg class="w-5 h-5 ml-1 -mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd"
                d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                clip-rule="evenodd"></path>
        </svg>
        </Link>
    </div>
</template>

<script>
import { Link } from '@inertiajs/vue3';


export default {
    props: ['next_page_url', 'prev_page_url', 'per_page', 'total', 'from', 'to'],
    data() {
        return {};
    },
    methods: {},
    components: { Link }
}

</script>