<template>
    <layout>
        <h1>Update Post</h1>
        <post-form v-bind:post="post"
                   v-bind:action="editPost"
                   v-bind:preview-image-action="previewImage"
                   submit-name="Update Post"></post-form>
    </layout>
</template>

<script>
    import axios from 'axios'
    import router from '../../../../routes'
    import SetErrorMessages from '../../shared/mixins/set_error_messages'
    import PreviewImage from '../../shared/mixins/preview_image'

    export default {
        name: "edit",
        mixin: [SetErrorMessages, PreviewImage],
        data: function() {
            return {
                post: { id: this.$route.params.id, title: '', content: '', image: '' },
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
                const data = {
                    title: this.post.title,
                    content: this.post.content,
                    image: this.post.image
                };
                axios.patch('/api/users/posts/' + this.post.id, data)
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