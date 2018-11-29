<template>
    <layout>
        <form class="form-generic form-post" id="new_post" action="/api/users/posts" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <h1>Create post</h1>
            <div class="field">
                <h5><label for="post_title">Title</label></h5>
                <input v-model="title" class="form-control" name="post[title]" type="text" id="post_title">
            </div>

            <div class="field">
                <h5><label for="post_content">Content</label></h5>
                <textarea v-model="content" class="form-control" name="post[content]" id="post_content"></textarea>
            </div>

            <div class="actions">
                <input v-on:click.prevent="createPost" type="submit" name="commit" value="Create Post" class="btn btn-lg btn-primary btn-block" data-disable-with="Create Post" />
            </div>
        </form>
    </layout>
</template>

<script>
    import axios from 'axios'
    import router from '../../../../routes'
    import Layout from '../../shared/layout'

    export default {
        components: { Layout },
        name: "new",
        data: function() {
            return {
                title: '',
                content: ''
            }
        },
        methods: {
            createPost: function () {
                axios.post('/api/users/posts', { title: this.title, content: this.content })
                     .then(result => {
                         if(result.status == 201) {
                             router.go(-1);
                             this.flashSuccess(result.data.notice, { timeout: 3000 });
                         }
                         else
                         {
                             this.flashError(result.data.notice, { timeout: 3000 });
                         }
                     })
                    .catch(error => {
                        console.log(error.response.data);
                     });
            }
        }
    }
</script>

<style scoped>

</style>