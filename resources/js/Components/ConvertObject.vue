<template>
    <div>
      <table class="min-w-full divide-y divide-gray-20 border border-gray-200 rounded-lg flex justify-between items-center dark:border-gray-6000">
        <!-- <thead>
          <tr>
            <th class="px-1 py-1 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Currency
            </th>
            <th class="px-1 py-1 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">
              Value
            </th>
          </tr>
        </thead> -->
        <tbody>
          <tr v-for="(value, currency) in currencyObject" :key="currency" >
            <td class="px-1 py-1 whitespace-no-wrap">
              {{ currency }}
            </td>
            <td class="px-1 py-1 whitespace-no-wrap">
              {{ formatMoney(value) }}
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>

  <script>
import globalMixin from "@/Mixins/global.js";

  export default {
    props: {
      currencyObject: Object,
    },

    mixins: [globalMixin],
  };
  </script>

  <style>
  /* You can customize the table styling here if needed */
  </style>
