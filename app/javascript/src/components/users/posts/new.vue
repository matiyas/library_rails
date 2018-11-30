<template>
    <layout>
        <h1>New Post</h1>
        <post-form v-bind:post="post"
                   v-bind:action="createPost"
                   v-bind:preview-image-action="previewImage"
                   submit-name="Create Post"></post-form>
    </layout>
</template>

<script>
    import axios from 'axios'
    import router from '../../../../routes'
    import Layout from '../../shared/layout'
    import PostForm from './_form'
    import SetErrorMessages from '../../shared/mixins/set_error_messages'
    import PreviewImage from '../../shared/mixins/preview_image'

    export default {
        name: "new",
        mixin: [SetErrorMessages, PreviewImage],
        components: { Layout, PostForm },
        data: function() {
            return {
                post: { title: '', content: '', image: '' }
            }
        },
        methods: {
            createPost: function () {
                const data = {
                    title: this.post.title,
                    content: this.post.content,
                    image: this.post.image
                };
                axios.post('/api/users/posts', data)
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