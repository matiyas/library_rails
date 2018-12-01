<template>
    <header>
        <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm fixed-top">
            <h5 class="my-0 mr-md-auto font-weight-normal"><router-link :to="{ name: 'root_path' }">Home</router-link></h5>
            <nav class="my-2 my-md-0 mr-md-3"></nav>
        </div>
    </header>
</template>

<script>
    export default {
        name: "nav-bar"
    }
</script>

<style scoped>

</style>