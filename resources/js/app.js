import './bootstrap';
import '../css/app.css';

import { createApp, h } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { ZiggyVue } from '../../vendor/tightenco/ziggy/dist/vue.m';
import 'flowbite';
import "vue3-snackbar/styles";
import { SnackbarService, Vue3Snackbar } from "vue3-snackbar";
const appName = import.meta.env.VITE_APP_NAME || 'Laravel';
import VueGoogleMaps from '@fawmi/vue-google-maps'
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)
            .use(SnackbarService)
            .use(VueGoogleMaps, {
                load: {
                    key: 'AIzaSyD2aMS3Zy5ru63unlPgw1uV4v-fa7iRDfU',
                    libraries: 'places',
                },
            })
            .component("vue3-snackbar", Vue3Snackbar)
            .component('Datepicker', VueDatePicker)
            .mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});
