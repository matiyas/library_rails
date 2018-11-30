<template>
    <form class="form-generic form-post" accept-charset="UTF-8" method="post">
        <input name="utf8" type="hidden" value="✓">
        <div class="field">
            <h5><label for="post_title">Title</label></h5>
            <input v-model="post.title" class="form-control" name="post[title]" type="text" id="post_title">
        </div>

        <div class="field">
            <img v-bind:src="post.image">
            <input type="file" @change="previewImageAction" accept="image/*">
        </div>

        <div class="field">
            <h5><label for="post_content">Content</label></h5>
            <textarea v-model="post.content" class="form-control" name="post[content]" id="post_content"></textarea>
        </div>

        <div class="actions">
            <input v-on:click.prevent="action"
                   type="submit"
                   name="commit"
                   v-bind:value="submitName"
                   class="btn btn-lg btn-primary btn-block"
                   v-bind:data-disable-with="submitName"
            />
        </div>
    </form>
</template>

<script>
    import UploadImage from 'vue-upload-image';

    export default {

        components: {UploadImage},
        props: ['post', 'action', 'submitName', 'previewImageAction']
    }
</script>

<style scoped>

</style>