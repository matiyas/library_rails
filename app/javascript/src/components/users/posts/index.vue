<template id="posts-index">
    <layout>
        <div>
            <h1>Posts</h1>
            <p>
                <router-link :to="{ name: 'new_post_path' }">
                    New post
                </router-link>
            </p>
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
                    <tr v-for="post in posts" :key="post.id">
                        <td>
                            <router-link v-bind:to="{ name: 'posts_path', params: { id: post.id } }">
                                {{ post.title.substr(0, 40) }}
                            </router-link>
                        </td>
                        <td>{{ post.content.substr(0, 100) }}</td>
                        <td>
                            <router-link v-bind:to="{ name: 'user_profile_path', params: { id: post.user_id } }">
                                {{ post.user_name }}
                            </router-link>
                        </td>
                        <td><timeago :datetime="post.created_at"></timeago></td>
                        <td><router-link :to="{ name: 'edit_post_path', params: { id: post.id } }">Edit</router-link></td>
                        <td><a v-on:click="deletePost(post)" :style="{ cursor: 'pointer' }">Delete</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </layout>
</template>

<script>
    import axios from 'axios';
    import Vue from 'vue/dist/vue.esm.js';
    import VueTimeago from 'vue-timeago';
    import VueRouter from 'vue-router';
    import router from '../../../../routes';

    Vue.use(VueRouter);
    Vue.use(VueTimeago);

    export default {
        name: "UsersPosts",
        data() {
            return {
                posts: null
            }
        },
        mounted() {
            axios.get('/api/users/posts')
                .then(response => { this.posts = response.data.posts })
                .catch(error => {
                    this.flashError(error.response.data.error);
                    router.push({ name: 'new_user_session_path' });
                });
        },
        methods: {
            deletePost: function(post) {
                if(window.confirm('Are you sure?')) {
                    axios.delete('/api/users/posts/' + post.id)
                        .then(response => {
                            const index = this.posts.indexOf(post);
                            this.posts.splice(index, 1);
                            this.flashSuccess(response.data.notice, { timeout: 3000 });
                        });
                }
            }
        }
    }
</script>