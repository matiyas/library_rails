<template>
    <header>
        <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm fixed-top">
            <h5 class="my-0 mr-md-auto font-weight-normal"><router-link :to="{ name: 'root_path' }">Home</router-link></h5>
            <nav class="my-2 my-md-0 mr-md-3">
                <button v-on:click="deleteSession" class='btn btn-outline-primary'>Logout</button>
            </nav>
        </div>
    </header>
</template>

<script>
    import axios from 'axios';
    import router from '../../../routes'

    export default {
        name: "nav-bar",
        methods: {
            deleteSession: function() {
                axios.delete('/api/users/sign_out')
                    .then(response => {
                        this.flashSuccess(response.data.notice, { timeout: 3000 });
                        router.push({ name: 'new_user_session_path' })
                    })
            }
        }
    }
</script>

<style scoped>

</style>