<template>
    <div
        class="relative inline-flex items-center justify-center w-10 h-10 overflow-hidden bg-gray-100 rounded-full dark:bg-gray-600">
        <span class="font-medium text-gray-600 dark:text-gray-300">{{ initials }}</span>
    </div>
</template>
<script>
export default {
    props: ['name'],

    computed: {
        initials() {
            return this.name.split(' ').map(word => word.charAt(0)).join('').toUpperCase();
        }
    }

}

</script>