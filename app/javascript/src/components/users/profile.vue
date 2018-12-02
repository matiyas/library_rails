<template>
    <layout>
        <gravatar v-bind:email="user.email"/>
        <h3>{{ user.name }}</h3>
        <p>{{ user.email }}</p>
    </layout>
</template>

<script>
    import axios from 'axios';

    export default {
        name: "profile",
        data: function() {
            return {
                user: { name: '', email: '' }
            }
        },
        mounted() {
            axios.get('/api/users/profiles/' + this.$route.params.id)
                .then(response => {
                    this.user = response.data.user;
                });
        },
    }
</script>
