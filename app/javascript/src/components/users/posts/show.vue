<template>
    <!--<% if can? :edit, @post %>-->
    <!--<%= link_to 'Edit', edit_users_post_path(@post) %>-->
    <!--<% end %>-->

    <div class="blog-post">
        <h2 class="blog-post-title">{{ post.title }}</h2>
        <p class="blog-post-meta">
            Created {{ new Date(post.created_at).toLocaleDateString() }} by
            <router-link :style="{ cursor: 'pointer' }" v-bind:to="{ name: 'user_profile_path', params: { id: post.user_id } }">
                {{ post.user_name }}
            </router-link>
        </p>

        <p>{{ post.content }}</p>
    </div>
</template>

<script>
    import axios from 'axios'

    export default {
        name: "show",
        data: function () {
            return {
                post: { title: '', content: '', created_at: '' }
            }
        },
        mounted() {
            var path = '/api/users/posts/' + this.$route.params.id;
            axios.get(path)
                .then(response => (this.post = response.data.post));
        }
    }
</script>

<style scoped>

</style>