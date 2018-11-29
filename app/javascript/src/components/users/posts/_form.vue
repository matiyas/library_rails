<template>
    <div>
        <div class="field">
            <h5><label for="post_title">Title</label></h5>
            <input v-model="title" class="form-control" name="post[title]" type="text" id="post_title">
        </div>

        <div class="field">
            <h5><label for="post_content">Content</label></h5>
            <textarea v-model="content" class="form-control" name="post[content]" id="post_content"></textarea>
        </div>
    </div>
</template>

<script>
    export default {
        data: function () {
            return { title: '', content: '' }
        }
    }
</script>

<style scoped>

</style>