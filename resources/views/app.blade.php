<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title inertia>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/assets/font-awesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/bootstrap-icons/bootstrap-icons.css">

    <!-- Scripts -->
    @routes
    @vite(['resources/js/app.js', "resources/js/Pages/{$page['component']}.vue"])
    @inertiaHead

    <style>
        /* chart styles */
        .apexcharts-tooltip {
            @apply bg-white dark:bg-gray-700 text-gray-500 dark:text-gray-400 border-0 rounded-lg shadow-lg !important;
        }

        .apexcharts-tooltip .apexcharts-tooltip-title {
            @apply py-2 px-4 bg-gray-100 dark:bg-gray-600 border-b border-gray-200 dark:border-gray-500 !important;
        }

        .apexcharts-xaxistooltip {
            @apply text-gray-500 border-0 bg-white dark:bg-gray-700 dark:text-gray-300 rounded-lg shadow-lg !important;
        }

        .apexcharts-tooltip .apexcharts-tooltip-text-y-value {
            @apply dark:text-white;
        }

        .apexcharts-xaxistooltip-text {
            @apply font-medium text-sm !important;
        }

        .apexcharts-xaxistooltip:before,
        .apexcharts-xaxistooltip:after {
            @apply border-0 !important;
        }

        /* SVG map styles */
        .svgMap-map-wrapper {
            @apply bg-white !important;
        }

        .svgMap-map-image {
            @apply dark:bg-gray-800;
        }

        .svgMap-map-controls-wrapper {
            @apply shadow-none left-0 bottom-0 dark:bg-gray-800 !important;
        }

        .svgMap-map-controls-zoom {
            @apply dark:bg-gray-800 !important;
        }

        .svgMap-map-wrapper .svgMap-control-button {
            @apply rounded-lg border-solid border border-gray-300 hover:bg-gray-100 dark:border-gray-600 dark:hover:bg-gray-600 !important;
        }

        .svgMap-map-wrapper .svgMap-control-button.svgMap-zoom-button:after,
        .svgMap-map-wrapper .svgMap-control-button.svgMap-zoom-button:before {
            @apply dark:bg-gray-600 dark:hover:bg-gray-500;
        }

        .svgMap-map-wrapper .svgMap-control-button:first-child {
            @apply mr-2 !important;
        }

        .svgMap-tooltip {
            @apply bg-white dark:bg-gray-700 shadow-lg rounded-lg border-0 text-left !important;
        }

        .svgMap-tooltip .svgMap-tooltip-content-container .svgMap-tooltip-flag-container {
            @apply inline-block mr-2 text-left border-0 p-0 !important;
        }

        .svgMap-tooltip .svgMap-tooltip-content-container .svgMap-tooltip-flag-container .svgMap-tooltip-flag {
            @apply inline-block border-0 h-4 p-0 !important;
        }

        .svgMap-tooltip .svgMap-tooltip-title {
            @apply inline-block pt-2 text-gray-900 dark:text-white font-semibold text-sm !important;
        }

        .svgMap-tooltip .svgMap-tooltip-content {
            @apply mt-0 !important;
        }

        .svgMap-tooltip .svgMap-tooltip-content table td {
            @apply text-sm text-left text-gray-500 dark:text-gray-400 font-normal !important;
        }

        .svgMap-tooltip .svgMap-tooltip-content table td span {
            @apply text-sm text-left text-gray-900 dark:text-white font-semibold !important;
        }

        .svgMap-tooltip .svgMap-tooltip-pointer {
            @apply hidden !important;
        }

        .svgMap-map-wrapper .svgMap-country {
            @apply dark:stroke-gray-800;
        }

        /* kanban styles */

        .drag-card {
            @apply opacity-100 !important;
            @apply rotate-6;
        }

        .ghost-card {
            @apply bg-gray-100/40 dark:bg-gray-600/40 !important;
        }

        /* calendar styles */

        .fc .fc-toolbar {
            @apply flex-row-reverse justify-end px-4 !important;
        }

        .fc .fc-toolbar.fc-header-toolbar {
            @apply mb-5 !important;
        }

        .fc .fc-toolbar-title {
            @apply text-lg text-gray-900 font-semibold !important;
        }

        .fc .fc-today-button {
            @apply rounded-lg border border-gray-200 bg-white text-sm font-medium px-4 py-2 text-gray-900 hover:bg-gray-100 hover:text-primary-700 focus:z-10 focus:ring-2 focus:ring-primary-700 focus:text-primary-700 !important;
        }

        .fc-direction-ltr .fc-toolbar>*> :not(:first-child) {
            @apply mx-2 !important;
        }

        .fc .fc-button-group .fc-prev-button,
        .fc .fc-button-group .fc-next-button {
            @apply bg-white border-0 text-gray-500 hover:text-gray-900 cursor-pointer p-2 hover:bg-gray-100 rounded inline-flex focus:bg-gray-100 focus:ring-1 focus:ring-gray-100 justify-center !important;
        }

        .fc .fc-scrollgrid {
            @apply border-l-0 border-gray-200 !important;
        }

        .fc .fc-daygrid-day-frame {
            @apply border-gray-200 !important;
        }

        .fc .fc-col-header-cell-cushion {
            @apply py-3 text-base text-gray-900 font-semibold !important;
        }

        .fc-theme-standard th {
            @apply border-0 border-b border-gray-200 !important;
        }

        .fc-direction-ltr .fc-daygrid-event.fc-event-end {
            @apply mr-2 !important;
        }

        .fc-direction-ltr .fc-daygrid-event.fc-event-start {
            @apply ml-2 !important;
        }

        .fc .fc-event .fc-event-main {
            @apply p-2 bg-primary-700 hover:bg-primary-800 !important;
        }

        .fc .fc-h-event .fc-event-main-frame {
            @apply text-xs font-semibold !important;
        }

        .fc .fc-daygrid-day-frame {
            @apply hover:bg-gray-50 cursor-pointer !important;
        }

        /* feed styles */

        @media (min-width: 1280px) {
            .feed-container {
                height: calc(100vh - 4rem);
            }
        }
    </style>
</head>

<body class="font-sans antialiased">
    @inertia
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.8.1/flowbite.min.js"></script>

</body>

</html>
