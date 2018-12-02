<template>
    <layout>
        <div id="admins-posts">
            <h1>Posts</h1>
            <table class="table">
                <thead>
                <tr>
                    <th>Title</th>
                    <th>Content</th>
                    <th>User</th>
                    <th>Created</th>
                    <th colspan="3"></th>
                </tr>
                </thead>

                <tbody>
                <tr v-for="post in posts">
                    <td><a v-bind:href="post.url">{{ post.title.substr(0, 40) }}</a></td>
                    <td>{{ post.content.substr(0, 100) }}</td>
                    <td><a v-bind:href="post.user_url">{{ post.user_id }}</a></td>
                    <td><timeago :datetime="post.created_at"></timeago></td>
                </tr>
                </tbody>
            </table>
        </div>
    </layout>
</template>

<script>
    import Layout from '../shared/layout'
    import axios from 'axios'
    import Vue from 'vue'
    import VueTimeago from 'vue-timeago'
    import router from '../../../routes'

    Vue.use(VueTimeago);

    export default {
        components: { Layout },
        name: "index",
        data() {
            return {
                posts: null
            }
        },
        mounted() {
            axios.get('/api/admins/posts')
                .then(response => (this.posts = response.data))
                .catch(error => {
                    this.flashError(error);

                    // if(error.result.status === 401) {
                    //     router.push({ name: 'new_user_session_path' });
                    // }
                })
        }
    }
</script>

<style scoped>

</style>