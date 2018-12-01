<template>
    <div>
        <nav-bar></nav-bar>
        <div class="container">
            <flash-message></flash-message>
            <slot/>
        </div>
    </div>
</template>

<script>
    import Vue from 'vue/dist/vue.esm.js';
    import VueFlashMessage from 'vue-flash-message';
    import NavBar from '../shared/nav_bar';

    Vue.use(VueFlashMessage);
    export default {
        components: { NavBar }
    }
</script>
