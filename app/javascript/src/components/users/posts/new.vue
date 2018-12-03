<template>
    <layout>
        <h1>New Post</h1>
        <post-form ref="postForm"
                   v-bind:post="post"
                   v-bind:action.prevent="createPost"
                   v-bind:preview-image-action="previewImage"
                   submit-name="Create Post"></post-form>
    </layout>
</template>

<script>
    import axios from 'axios'
    import router from '../../../../routes'
    import SetErrorMessages from '../../shared/mixins/set_error_messages'
    import PreviewImage from '../../shared/mixins/preview_image'

    export default {
        name: "new",
        mixin: [SetErrorMessages, PreviewImage],
        data: function() {
            return {
                post: { title: '', content: '', image: '' }
            }
        },
        methods: {
            createPost: function () {
                var data = new FormData(this.$refs.postForm.$el);

                const config = {
                    headers: {
                        'Content-Type': 'multipart/form-data',
                    }
                };

                axios.post('/api/users/posts', data, config)
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