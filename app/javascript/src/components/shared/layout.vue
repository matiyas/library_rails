<template>
    <div class="container">
        <flash-message></flash-message>
        <slot/>
    </div>
</template>

<script>
    import Vue from 'vue/dist/vue.esm.js';
    import VueFlashMessage from 'vue-flash-message';
    Vue.use(VueFlashMessage);
</script>
