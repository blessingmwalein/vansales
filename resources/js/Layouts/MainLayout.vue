<script >

import { Head, Link, router } from '@inertiajs/vue3';

import NavTop from '@/Components/navs/NavTop.vue';
import SideNav from '@/Components/navs/SideNav.vue';
import Footer from '@/Components/navs/Footer.vue';
import globalMixin from "@/Mixins/global.js";



export default {
    components: {
        NavTop,
        SideNav,
        Footer,
    },
    mixins: [globalMixin],
    

    mounted() {

    },
    methods: {
        logout() {
            this.$post(route('logout'));
        }
    },
    watch: {
        //watch to flash messages
        $page(newProps, oldProps) {
            console.log(newProps.props);
            if (newProps.props.success) {
                this.fireSnackbar(newProps.props.success, "Success", "#31CF80", "info");
            }
            if (newProps.props.error) {
                this.fireSnackbar(newProps.props.error, "Error", "#D82C5B", "info");
            }
            // if (newProps.props.flash.message) {
            //     this.fireSnackbar(newProps.props.flash.message, "Message", "#2DADCF", "info");
            // }
        },
    },
}

</script>

<template>
    <NavTop />
    <div class="flex pt-16 overflow-hidden bg-gray-50 dark:bg-gray-900">

        <SideNav />

        <div id="main-content" class="relative w-full h-full overflow-y-auto bg-gray-50 lg:ml-64 dark:bg-gray-900">
            <main>
                <slot />
            </main>
            <Footer />
            <vue3-snackbar bottom right :duration="4000"></vue3-snackbar>

        </div>

    </div>
</template>
