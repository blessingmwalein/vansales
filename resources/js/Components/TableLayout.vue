<template>
    <slot name="table" v-if="hasData"></slot>
    <div class="flex items-center mt-6 text-center border rounded-lg h-96 dark:border-gray-700 m-4" v-else>
        <div class="flex flex-col w-full max-w-sm px-4 mx-auto">
            <div class="p-3 mx-auto text-blue-500 bg-blue-100 rounded-full dark:bg-gray-800">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                    stroke="currentColor" class="w-6 h-6">
                    <path stroke-linecap="round" stroke-linejoin="round"
                        d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
                </svg>
            </div>
            <h1 class="mt-3 text-lg text-gray-800 dark:text-white">Opps No records found</h1>
            <!-- <p class="mt-2 text-gray-500 dark:text-gray-400">Your search “Stripe” did not match any vendors. Please try
                again or create add a new vendor.</p> -->
            <div class="flex items-center mt-4 sm:mx-auto gap-x-3">


                <slot name="action-button"></slot>

            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: ['hasData'],
    data() {
        return {
        }
    },

    methods: {
    }
}
</script>