<template>
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
                <td>{{ post.title.substr(0, 40) }}</td>
                <td>{{ post.content.substr(0, 100) }}</td>
                <td>{{ post.user_id }}</td>
                <td><timeago :datetime="post.created_at"></timeago></td>
                <!--<td><%= link_to post.title.truncate(40), [:admins, post] %></td>-->
                <!--<td><%= post.content.truncate(100) %></td>-->
                <!--<td><%= link_to post.user.name, profile_path(post.user) %></td>-->
                <!--<td><%= time_ago_in_words(post.created_at) %> ago</td>-->
                <!--<% if can? :edit, post %>-->
                <!--<td><%= link_to 'Edit', edit_admins_post_path(post) %></td>-->
                <!--<% end %>-->
                <!--<% if can? :destroy, post %>-->
                <!--<td><%= link_to 'Destroy', [:admins, post], method: :delete, data: { confirm: 'Are you sure?' } %></td>-->
                <!--<% end %>-->
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
    import axios from 'axios'
    import Vue from 'vue'
    import VueTimeago from 'vue-timeago'

    Vue.use(VueTimeago);

    export default {
        name: "index",
        data() {
            return {
                posts: null
            }
        },
        mounted() {
            axios.get('/api/admins/posts?page=3')
                .then(response => (this.posts = response.data))
        }
    }
</script>

<style scoped>

</style>