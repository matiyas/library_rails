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
    import Vue from 'vue/dist/vue.esm.js'
    import VueFlashMessage from 'vue-flash-message'

    Vue.use(VueFlashMessage);

    export default {}
</script>
