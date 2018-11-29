<template>
    <layout>
        <h1>New Post</h1>
        <post-form v-bind:post="post" v-bind:action="createPost" submit-name="Create Post"></post-form>
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
                post: { title: '', content: '' }
            }
        },
        methods: {
            createPost: function () {
                axios.post('/api/users/posts', { title: this.post.title, content: this.post.content })
                     .then(result => {
                             router.go(-1);
                             this.flashSuccess(result.data.notice, { timeout: 3000 });
                     })
                    .catch(error => {
                        this.setFieldsWithErrors(error.response.data);
                     });
            }
        }
    }
</script>

<style scoped>

</style>