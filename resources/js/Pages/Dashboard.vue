<script >
import MainLayout from '@/Layouts/MainLayout.vue';

export default {
    components: {
        MainLayout,
    },

    props: [
        'employees',
        'newEmployees',
        'totalEarnings',
        'totalEarningsThisMonth',
        'totalInvoices',
        'newInvoices'
    ],
    data() {
        return {
            defaultCurrency: this.$page.props?.defaultCurrency,

            mainChartColors: {
                borderColor: '#F3F4F6',
                labelColor: '#6B7280',
                opacityFrom: 0.45,
                opacityTo: 0,
            },
            options: {
                chart: {
                    id: 'vuechart-example',
                    height: 420,
                    type: 'area',
                    fontFamily: 'Inter, sans-serif',
                    foreColor: "#6B7280",
                    toolbar: {
                        show: false
                    }
                },
                xaxis: {
                    categories: ['Jan', 'Feb', 'March', 'April', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov',
                        'Dec'
                    ],
                    labels: {
                        style: {
                            colors: ["#6B7280"],
                            fontSize: '14px',
                            fontWeight: 500,
                        },
                    },
                    axisBorder: {
                        color: "##F3F4F6",
                    },
                    axisTicks: {
                        color: "##F3F4F6",
                    },
                    crosshairs: {
                        show: true,
                        position: 'back',
                        stroke: {
                            color: "##F3F4F6",
                            width: 1,
                            dashArray: 10,
                        },
                    },
                },
                yaxis: {
                    labels: {
                        style: {
                            colors: ["#6B7280"],
                            fontSize: '14px',
                            fontWeight: 500,
                        },
                        formatter: function (value) {
                            return '$' + value;
                        }
                    },
                },
                markers: {
                    size: 5,
                    strokeColors: '#ffffff',
                    hover: {
                        size: undefined,
                        sizeOffset: 3
                    },

                },

                grid: {
                    show: true,
                    borderColor: "#F3F4F6",
                    strokeDashArray: 1,
                    padding: {
                        left: 35,
                        bottom: 15
                    }
                },
                legend: {
                    fontSize: '14px',
                    fontWeight: 500,
                    fontFamily: 'Inter, sans-serif',
                    labels: {
                        colors: ["#6B7280"]
                    },
                    itemMargin: {
                        horizontal: 10
                    }
                },
                responsive: [
                    {
                        breakpoint: 1024,
                        options: {
                            xaxis: {
                                labels: {
                                    show: false
                                }
                            }
                        }
                    }
                ],
                tooltip: {
                    style: {
                        fontSize: '14px',
                        fontFamily: 'Inter, sans-serif',
                    },
                },

                dataLabels: {
                    enabled: false
                },
            },
            // series: [
            //     {
            //         name: 'Revenue',
            //         data: this.formartSales(),
            //         color: '#1A56DB'
            //     },
            //     // {
            //     //     name: 'Revenue (previous period)',
            //     //     data: [6556, 6725, 6424, 6356, 6586, 6756, 6616],
            //     //     color: '#FDBA8C'
            //     // }
            // ],

            newProductsOptions: {
                colors: ['#1A56DB', '#FDBA8C'],
                series: [
                    {
                        name: 'Quantity',
                        color: '#1A56DB',
                        data: [
                            { x: '01 Feb', y: 170 },
                            { x: '02 Feb', y: 180 },
                            { x: '03 Feb', y: 164 },
                            { x: '04 Feb', y: 145 },
                            { x: '05 Feb', y: 194 },
                            { x: '06 Feb', y: 170 },
                            { x: '07 Feb', y: 155 },
                        ]
                    }
                ],
                chart: {
                    type: 'bar',
                    height: '140px',
                    fontFamily: 'Inter, sans-serif',
                    foreColor: '#4B5563',
                    toolbar: {
                        show: false
                    }
                },
                plotOptions: {
                    bar: {
                        columnWidth: '90%',
                        borderRadius: 3
                    }
                },
                tooltip: {
                    shared: false,
                    intersect: false,
                    style: {
                        fontSize: '14px',
                        fontFamily: 'Inter, sans-serif'
                    },
                },
                states: {
                    hover: {
                        filter: {
                            type: 'darken',
                            value: 1
                        }
                    }
                },
                stroke: {
                    show: true,
                    width: 5,
                    colors: ['transparent']
                },
                grid: {
                    show: false
                },
                dataLabels: {
                    enabled: false
                },
                legend: {
                    show: false
                },
                xaxis: {
                    floating: false,
                    labels: {
                        show: false
                    },
                    axisBorder: {
                        show: false
                    },
                    axisTicks: {
                        show: false
                    },
                },
                yaxis: {
                    show: false
                },
                fill: {
                    opacity: 1
                }
            },

            newUsersChatOptions: {
                series: [{
                    name: 'Users',
                    data: [1334, 2435, 1753, 1328, 1155, 1632, 1336]
                }],
                labels: ['01 Feb', '02 Feb', '03 Feb', '04 Feb', '05 Feb', '06 Feb', '07 Feb'],
                chart: {
                    type: 'bar',
                    height: '140px',
                    foreColor: '#4B5563',
                    fontFamily: 'Inter, sans-serif',
                    toolbar: {
                        show: false
                    }
                },
                theme: {
                    monochrome: {
                        enabled: true,
                        color: '#1A56DB'
                    }
                },
                plotOptions: {
                    bar: {
                        columnWidth: '25%',
                        borderRadius: 3,
                        colors: {
                            backgroundBarColors: ['#E5E7EB', '#E5E7EB', '#E5E7EB', '#E5E7EB', '#E5E7EB', '#E5E7EB', '#E5E7EB'],
                            backgroundBarRadius: 3
                        },
                    },
                    dataLabels: {
                        hideOverflowingLabels: false
                    }
                },
                xaxis: {
                    floating: false,
                    labels: {
                        show: false
                    },
                    axisBorder: {
                        show: false
                    },
                    axisTicks: {
                        show: false
                    },
                },
                tooltip: {
                    shared: true,
                    intersect: false,
                    style: {
                        fontSize: '14px',
                        fontFamily: 'Inter, sans-serif'
                    }
                },
                states: {
                    hover: {
                        filter: {
                            type: 'darken',
                            value: 0.8
                        }
                    }
                },
                fill: {
                    opacity: 1
                },
                yaxis: {
                    show: false
                },
                grid: {
                    show: false
                },
                dataLabels: {
                    enabled: false
                },
                legend: {
                    show: false
                },
            }
        }
    },
    methods: {
        formartSales() {
            //map sales into array of total price replace month without total with 0
            var salesListByMonth = []
            for (var i = 0; i < 12; i++) {
                salesListByMonth.push(0)
            }

            this.sales.forEach(sale => {
                salesListByMonth[sale.month - 1] = sale.total
            });

            return salesListByMonth

        },
        toggleStatisticsTab(id) {

            if (id == 'products-tab') {
                document.getElementById('products-tab').classList.remove('hidden');
                document.getElementById('salesman-tab').classList.add('hidden');
            } else {
                document.getElementById('products-tab').classList.add('hidden');
                document.getElementById('salesman-tab').classList.remove('hidden');
            }
        }
    }
}
</script>

<template>
    <MainLayout>
        <section class="grid gap-6 my-6 md:grid-cols-3 h-100 p-4">
            <div class="p-6 bg-white shadow rounded-2xl">
                <dl class="space-y-2">
                    <dt class="text-sm font-medium text-gray-500">Employees</dt>

                    <dd class="text-5xl font-light md:text-6xl">{{ employees }}</dd>

                    <dd class="flex items-center space-x-1 text-sm font-medium text-green-500">
                        <span>{{ newEmployees }} this month</span>

                        <svg v-if="newEmployees > 0" class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17.25 15.25V6.75H8.75"></path>
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17 7L6.75 17.25"></path>
                        </svg>

                        <svg v-else class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
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
                    <dt class="text-sm font-medium text-gray-500">Total Earnings</dt>

                    <dd class="text-5xl font-light md:text-6xl">{{defaultCurrency?.code}}{{ totalEarnings }}</dd>

                    <dd class="flex items-center space-x-1 text-sm font-medium text-red-500">
                        <span>{{defaultCurrency?.code}}{{ totalEarningsThisMonth }} this month</span>

                        <svg v-if="totalEarningsThisMonth <= 0" class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17.25 8.75V17.25H8.75"></path>
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17 17L6.75 6.75"></path>
                        </svg>

                        <svg v-else class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
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
                    <dt class="text-sm font-medium text-gray-500">Total Invoices</dt>

                    <dd class="text-5xl font-light md:text-6xl">{{ totalInvoices }}</dd>

                    <dd class="flex items-center space-x-1 text-sm font-medium text-green-500">
                        <span>{{ newInvoices }} this month</span>

                        <svg v-if="newInvoices <= 0" class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none"
                            viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17.25 8.75V17.25H8.75"></path>
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17 17L6.75 6.75"></path>
                        </svg>

                        <svg v-else class="w-7 h-7" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17.25 15.25V6.75H8.75"></path>
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                d="M17 7L6.75 17.25"></path>
                        </svg>
                    </dd>
                </dl>
            </div>
        </section>
        <!-- <div class="px-4 pt-6">
            <div class="grid gap-4 xl:grid-cols-2 2xl:grid-cols-3">
                <div
                    class="p-4 bg-white border border-gray-200 rounded-lg shadow-sm 2xl:col-span-2 dark:border-gray-700 sm:p-6 dark:bg-gray-800">
                    <div class="flex items-center justify-between mb-4">
                        <div class="flex-shrink-0">
                            <span
                                class="text-xl font-bold leading-none text-gray-900 sm:text-2xl dark:text-white">{{defaultCurrency?.symbol}}{{ totalSales }}</span>
                            <h3 class="text-base font-light text-gray-500 dark:text-gray-400">Sales this week</h3>
                        </div>
                        <div
                            class="flex items-center justify-end flex-1 text-base font-medium text-green-500 dark:text-green-400">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M5.293 7.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 5.414V17a1 1 0 11-2 0V5.414L6.707 7.707a1 1 0 01-1.414 0z"
                                    clip-rule="evenodd"></path>
                            </svg>
                        </div>
                    </div>

                    <apexchart type="area" :options="options" :series="series"></apexchart>

                    <div
                        class="flex items-center justify-between pt-3 mt-4 border-t border-gray-200 sm:pt-6 dark:border-gray-700">
                        <div>
                            <button
                                class="inline-flex items-center p-2 text-sm font-medium text-center text-gray-500 rounded-lg hover:text-gray-900 dark:text-gray-400 dark:hover:text-white"
                                type="button" data-dropdown-toggle="weekly-sales-dropdown">Last 7 days <svg
                                    class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 9l-7 7-7-7"></path>
                                </svg></button>
                            <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded shadow dark:bg-gray-700 dark:divide-gray-600"
                                id="weekly-sales-dropdown">
                                <div class="px-4 py-3" role="none">
                                    <p class="text-sm font-medium text-gray-900 truncate dark:text-white" role="none">
                                        Sep 16, 2021 - Sep 22, 2021
                                    </p>
                                </div>
                                <ul class="py-1" role="none">
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Yesterday</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Today</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Last 7 days</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Last 30 days</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Last 90 days</a>
                                    </li>
                                </ul>
                                <div class="py-1" role="none">
                                    <a href="#"
                                        class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                        role="menuitem">Custom...</a>
                                </div>
                            </div>
                        </div>
                        <div class="flex-shrink-0">
                            <a href="#"
                                class="inline-flex items-center p-2 text-xs font-medium uppercase rounded-lg text-primary-700 sm:text-sm hover:bg-gray-100 dark:text-primary-500 dark:hover:bg-gray-700">
                                Sales Report
                                <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7">
                                    </path>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                <div
                    class="p-4 bg-white border border-gray-200 rounded-lg shadow-sm dark:border-gray-700 sm:p-6 dark:bg-gray-800">
                    <h3 class="flex items-center mb-4 text-lg font-semibold text-gray-900 dark:text-white">Statistics this
                        month
                        <button data-popover-target="popover-description" data-popover-placement="bottom-end"
                            type="button"><svg class="w-4 h-4 ml-2 text-gray-400 hover:text-gray-500" aria-hidden="true"
                                fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
                                    d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z"
                                    clip-rule="evenodd"></path>
                            </svg><span class="sr-only">Show information</span></button>
                    </h3>

                    <div class="sm:hidden">
                        <label for="tabs" class="sr-only">Select tab</label>
                        <select id="tabs"
                            class="bg-gray-50 border-0 border-b border-gray-200 text-gray-900 text-sm rounded-t-lg focus:ring-primary-500 focus:border-primary-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500">
                            <option>Statistics</option>
                            <option>Services</option>
                            <option>FAQ</option>
                        </select>
                    </div>
                    <ul class="hidden text-sm font-medium text-center text-gray-500 divide-x divide-gray-200 rounded-lg sm:flex dark:divide-gray-600 dark:text-gray-400"
                        id="fullWidthTab" data-tabs-toggle="#fullWidthTabContent" role="tablist">
                        <li class="w-full">
                            <button @click="toggleStatisticsTab('products-tab')" type="button" role="tab"
                                aria-controls="faq" aria-selected="true"
                                class="inline-block w-full p-4 rounded-tl-lg bg-gray-50 hover:bg-gray-100 focus:outline-none dark:bg-gray-700 dark:hover:bg-gray-600">Top
                                products</button>
                        </li>
                        <li class="w-full">
                            <button @click="toggleStatisticsTab('salesman-tab')" type="button" role="tab"
                                aria-controls="about" aria-selected="false"
                                class="inline-block w-full p-4 rounded-tr-lg bg-gray-50 hover:bg-gray-100 focus:outline-none dark:bg-gray-700 dark:hover:bg-gray-600">Top
                                Salesman</button>
                        </li>
                    </ul>
                    <div id="fullWidthTabContent" class="border-t border-gray-200 dark:border-gray-600">
                        <div class=" pt-4" id="products-tab" role="tabpanel">
                            <ul  role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                                <li class="py-3 sm:py-4" v-for="product in topSoldProducts?.data">
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center min-w-0">
                                            <img class="flex-shrink-0 w-10 h-10"
                                                :src="`/storage/${product?.stock?.product?.image}`" alt="imac image">
                                            <div class="ml-3">
                                                <p class="font-medium text-gray-900 truncate dark:text-white">
                                                    {{ product?.stock?.product?.description }}
                                                </p>
                                                <div
                                                    class="flex items-center justify-end flex-1 text-sm text-green-500 dark:text-green-400">
                                                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"
                                                        xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                                        <path clip-rule="evenodd" fill-rule="evenodd"
                                                            d="M10 17a.75.75 0 01-.75-.75V5.612L5.29 9.77a.75.75 0 01-1.08-1.04l5.25-5.5a.75.75 0 011.08 0l5.25 5.5a.75.75 0 11-1.08 1.04l-3.96-4.158V16.25A.75.75 0 0110 17z">
                                                        </path>
                                                    </svg>
                                                    2.5%
                                                    <span class="ml-2 text-gray-500">vs last month</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div
                                            class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                            ${{ product?.total_price }}
                                        </div>
                                    </div>
                                </li>

                            </ul>
                        </div>
                        <div class="hidden pt-4" id="salesman-tab" role="tabpanel">
                            <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                                <li class="py-3 sm:py-4">
                                    <div class="flex items-center space-x-4">
                                        <div class="flex-shrink-0">
                                            <img class="w-8 h-8 rounded-full" src="/assets/user.webp" alt="Neil image">
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="font-medium text-gray-900 truncate dark:text-white">
                                                Neil Sims
                                            </p>
                                            <p class="text-sm text-gray-500 truncate dark:text-gray-400">
                                                email@Aximos.com
                                            </p>
                                        </div>
                                        <div
                                            class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                            $3320
                                        </div>
                                    </div>
                                </li>
                                <li class="py-3 sm:py-4">
                                    <div class="flex items-center space-x-4">
                                        <div class="flex-shrink-0">
                                            <img class="w-8 h-8 rounded-full" src="/assets/user.webp" alt="Neil image">
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="font-medium text-gray-900 truncate dark:text-white">
                                                Bonnie Green
                                            </p>
                                            <p class="text-sm text-gray-500 truncate dark:text-gray-400">
                                                email@Aximos.com
                                            </p>
                                        </div>
                                        <div
                                            class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                            $2467
                                        </div>
                                    </div>
                                </li>
                                <li class="py-3 sm:py-4">
                                    <div class="flex items-center space-x-4">
                                        <div class="flex-shrink-0">
                                            <img class="w-8 h-8 rounded-full" src="/assets/user.webp" alt="Neil image">
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="font-medium text-gray-900 truncate dark:text-white">
                                                Michael Gough
                                            </p>
                                            <p class="text-sm text-gray-500 truncate dark:text-gray-400">
                                                email@Aximos.com
                                            </p>
                                        </div>
                                        <div
                                            class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                            $2235
                                        </div>
                                    </div>
                                </li>
                                <li class="py-3 sm:py-4">
                                    <div class="flex items-center space-x-4">
                                        <div class="flex-shrink-0">
                                            <img class="w-8 h-8 rounded-full" src="/assets/user.webp" alt="Neil image">
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="font-medium text-gray-900 truncate dark:text-white">
                                                Thomes Lean
                                            </p>
                                            <p class="text-sm text-gray-500 truncate dark:text-gray-400">
                                                email@Aximos.com
                                            </p>
                                        </div>
                                        <div
                                            class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                            $1842
                                        </div>
                                    </div>
                                </li>
                                <li class="py-3 sm:py-4">
                                    <div class="flex items-center space-x-4">
                                        <div class="flex-shrink-0">
                                            <img class="w-8 h-8 rounded-full" src="/assets/user.webp" alt="Neil image">
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="font-medium text-gray-900 truncate dark:text-white">
                                                Lana Byrd
                                            </p>
                                            <p class="text-sm text-gray-500 truncate dark:text-gray-400">
                                                email@Aximos.com
                                            </p>
                                        </div>
                                        <div
                                            class="inline-flex items-center text-base font-semibold text-gray-900 dark:text-white">
                                            $1044
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div
                        class="flex items-center justify-between pt-3 mt-5 border-t border-gray-200 sm:pt-6 dark:border-gray-700">
                        <div>
                            <button
                                class="inline-flex items-center p-2 text-sm font-medium text-center text-gray-500 rounded-lg hover:text-gray-900 dark:text-gray-400 dark:hover:text-white"
                                type="button" data-dropdown-toggle="stats-dropdown">Last 7 days <svg class="w-4 h-4 ml-2"
                                    fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M19 9l-7 7-7-7"></path>
                                </svg></button>
                            <div class="z-50 hidden my-4 text-base list-none bg-white divide-y divide-gray-100 rounded shadow dark:bg-gray-700 dark:divide-gray-600"
                                id="stats-dropdown">
                                <div class="px-4 py-3" role="none">
                                    <p class="text-sm font-medium text-gray-900 truncate dark:text-white" role="none">
                                        Sep 16, 2021 - Sep 22, 2021
                                    </p>
                                </div>
                                <ul class="py-1" role="none">
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Yesterday</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Today</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Last 7 days</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Last 30 days</a>
                                    </li>
                                    <li>
                                        <a href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                            role="menuitem">Last 90 days</a>
                                    </li>
                                </ul>
                                <div class="py-1" role="none">
                                    <a href="#"
                                        class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 dark:text-gray-400 dark:hover:bg-gray-600 dark:hover:text-white"
                                        role="menuitem">Custom...</a>
                                </div>
                            </div>
                        </div>
                        <div class="flex-shrink-0">
                            <a href="#"
                                class="inline-flex items-center p-2 text-xs font-medium uppercase rounded-lg text-primary-700 sm:text-sm hover:bg-gray-100 dark:text-primary-500 dark:hover:bg-gray-700">
                                Full Report
                                <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7">
                                    </path>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="grid w-full grid-cols-1 gap-4 mt-4 xl:grid-cols-2 2xl:grid-cols-3">
                <div
                    class="items-center justify-between p-4 bg-white border border-gray-200 rounded-lg shadow-sm sm:flex dark:border-gray-700 sm:p-6 dark:bg-gray-800">
                    <div class="w-full">
                        <h3 class="text-base font-normal text-gray-500 dark:text-gray-400">New products</h3>
                        <span class="text-2xl font-bold leading-none text-gray-900 sm:text-3xl dark:text-white">{{newProducts}}</span>
                        <p class="flex items-center text-base font-normal text-gray-500 dark:text-gray-400">
                            <span class="flex items-center mr-1.5 text-sm text-green-500 dark:text-green-400">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path clip-rule="evenodd" fill-rule="evenodd"
                                        d="M10 17a.75.75 0 01-.75-.75V5.612L5.29 9.77a.75.75 0 01-1.08-1.04l5.25-5.5a.75.75 0 011.08 0l5.25 5.5a.75.75 0 11-1.08 1.04l-3.96-4.158V16.25A.75.75 0 0110 17z">
                                    </path>
                                </svg>
                            </span>
                            Since last month
                        </p>
                    </div>
                    <apexchart type="bar" height="150" :options="newProductsOptions" :series="newProductsOptions.series">
                    </apexchart>
                </div>
                <div
                    class="items-center justify-between p-4 bg-white border border-gray-200 rounded-lg shadow-sm sm:flex dark:border-gray-700 sm:p-6 dark:bg-gray-800">
                    <div class="w-full">
                        <h3 class="text-base font-normal text-gray-500 dark:text-gray-400">Users</h3>
                        <span class="text-2xl font-bold leading-none text-gray-900 sm:text-3xl dark:text-white">{{newUsers}}</span>
                        <p class="flex items-center text-base font-normal text-gray-500 dark:text-gray-400">
                            <span class="flex items-center mr-1.5 text-sm text-green-500 dark:text-green-400">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path clip-rule="evenodd" fill-rule="evenodd"
                                        d="M10 17a.75.75 0 01-.75-.75V5.612L5.29 9.77a.75.75 0 01-1.08-1.04l5.25-5.5a.75.75 0 011.08 0l5.25 5.5a.75.75 0 11-1.08 1.04l-3.96-4.158V16.25A.75.75 0 0110 17z">
                                    </path>
                                </svg>
                            </span>
                            Since last month
                        </p>
                    </div>
                    <apexchart type="bar" height="150" :options="newUsersChatOptions" :series="newUsersChatOptions.series">
                    </apexchart>
                </div>

            </div>
        </div> -->
    </MainLayout>
</template>
<style></style>
