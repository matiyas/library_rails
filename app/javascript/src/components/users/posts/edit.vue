<template>
    <layout>
        <h1>Update Post</h1>
        <post-form v-bind:post="post" v-bind:action="editPost" submit-name="Update Post"></post-form>
    </layout>
</template>

<script>
    import axios from 'axios'
    import router from '../../../../routes'
    import Layout from '../../shared/layout'
    import PostForm from './_form'
    import SetErrorMessages from '../../shared/set_error_messages'

    export default {
        name: "new",
        mixin: [SetErrorMessages],
        components: { Layout, PostForm },
        data: function() {
            return {
                post: { id: this.$route.params.id, title: '', content: '' },
            }
        },
        mounted() {
            axios.get('/api/users/posts/' + this.post.id + '/edit')
                .then(response => {
                    this.post = response.data.post;
                });
        },
        methods: {
            editPost: function () {
                axios.patch('/api/users/posts/' + this.post.id, { title: this.post.title, content: this.post.content })
                    .then(result => {
                        router.go(-1);
                        this.flashSuccess(result.data.notice, { timeout: 3000 });
                    })
                    .catch(error => {
                        this.setFieldsWithErrors(error.response.data);
                    });
            },
        }
    }
</script>

<style scoped>

</style>