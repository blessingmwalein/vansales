<template>
    <multiselect class="block mb-2 text-sm font-medium text-gray-900 dark:text-white   dark:border-gray-600"
        v-model="searchForm.status" :options="options" :multiple="true" placeholder="Filter by status" label="name"
        track-by="id">
    </multiselect>
</template>
<script>
import Multiselect from 'vue-multiselect'
export default {
    components: { Multiselect },
    props: ['options'],
    data() {
        return {

        }
    },
}

</script>