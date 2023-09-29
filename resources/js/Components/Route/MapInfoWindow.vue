<template>
    <div style="width:200px"
        class="w-30 max-w-sm bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">

        <div class="flex flex-col items-center pb-10">
            <img class="w-20 h-20 mb-3 rounded-full" src="/assets/location.svg" alt="Bonnie image" />
            <h5 class="mb-1 text-xl font-medium text-gray-900 dark:text-white">{{ node.name }}</h5>
            <span class=" text-sm text-gray-500 dark:text-gray-400">

                <CopyButton @click="copyToClipboard(`${node.position.lat} ${node.position.lon}`)" />
            </span>

        </div>
    </div>
</template>
<script>
import globalMixin from "@/Mixins/global.js";

import CopyButton from '@/Components/CopyButton.vue';
export default {
    props: ['node'],
    components: {
        CopyButton
    },
    mixins: [globalMixin],
}
</script>