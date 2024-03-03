<template>
    <section class="grid gap-6 my-6 md:grid-cols-3 h-100 p-4">
        <div class="p-6 bg-white shadow rounded-2xl">
            <dl class="space-y-2">
                <dt class="text-sm font-medium text-gray-500">Companies</dt>

                <dd class="text-5xl font-light md:text-6xl">{{ companies }}</dd>

                <dd class="flex items-center space-x-1 text-sm font-medium text-green-500">
                    <span>{{ newCompanies }} this month</span>

                    <svg v-if="newCompanies > 0" class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                        viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17.25 15.25V6.75H8.75"></path>
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17 7L6.75 17.25"></path>
                    </svg>

                    <svg v-else class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                        viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17.25 8.75V17.25H8.75"></path>
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17 17L6.75 6.75"></path>
                    </svg>
                </dd>
            </dl>
        </div>

        <div class="p-6 bg-white shadow rounded-2xl">
            <dl class="space-y-2">
                <dt class="text-sm font-medium text-gray-500">Subscriptions</dt>

                <dd class="text-5xl font-light md:text-6xl">{{ subscriptions }}</dd>

                <dd class="flex items-center space-x-1 text-sm font-medium text-red-500">
                    <span>{{ companySubscriptions }} company subscribed</span>

                    <svg v-if="companySubscriptions <= 0" class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                        viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17.25 8.75V17.25H8.75"></path>
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17 17L6.75 6.75"></path>
                    </svg>

                    <svg v-else class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                        viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17.25 15.25V6.75H8.75"></path>
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17 7L6.75 17.25"></path>
                    </svg>
                </dd>
            </dl>
        </div>

        <div class="p-6 bg-white shadow rounded-2xl">
            <dl class="space-y-2">
                <dt class="text-sm font-medium text-gray-500">Users</dt>

                <dd class="text-5xl font-light md:text-6xl">{{ users }}</dd>

                <dd class="flex items-center space-x-1 text-sm font-medium text-green-500">
                    <span>{{ newUsers }} this month</span>

                    <svg v-if="newUsers <= 0" class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                        viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17.25 8.75V17.25H8.75"></path>
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17 17L6.75 6.75"></path>
                    </svg>

                    <svg v-else class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                        viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17.25 15.25V6.75H8.75"></path>
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                            d="M17 7L6.75 17.25"></path>
                    </svg>
                </dd>
            </dl>
        </div>
    </section>
</template>
<script>
import MainLayout from '@/Layouts/MainLayout.vue';


export default {
    layout: MainLayout,
    props: [
        'companies',
        'users',
        'newCompanies',
        'subscriptions',
        'newUsers',
        'companySubscriptions'
    ],
    metaInfo: {
        title: 'Admin Dashboard',
    },
    components: {
        MainLayout
    },
    data() {
        return {
        }
    },
    methods: {
    },
    mounted() {
    }

}
</script>
