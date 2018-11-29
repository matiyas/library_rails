<template>
    <div class="container">
        <form class="form-generic form-signin" id="new_user" action="/users/sign_in" accept-charset="UTF-8" method="post">
            <input name="utf8" type="hidden" value="✓">
            <h2>Log in</h2>

            <div class="field">
                <input autofocus="autofocus" autocomplete="email" class="form-control" placeholder="Email address" type="email" value="" name="user[email]" id="user_email">
            </div>

            <div class="field">
                <input autocomplete="current-password" class="form-control" placeholder="Password" type="password" name="user[password]" id="user_password">
            </div>

            <div class="field checkbox mb-3">
                <input name="user[remember_me]" type="hidden" value="0">
                <input type="checkbox" value="1" name="user[remember_me]" id="user_remember_me"> Remember me
            </div>

            <div class="actions">
                <input type="submit" name="commit" value="Log in" class="btn btn-lg btn-primary btn-block">
            </div>

            <a href="/users/sign_up">Sign up</a><br>

            <a href="/users/password/new">Forgot your password?</a><br>

            <a href="/users/confirmation/new">Didn't receive confirmation instructions?</a><br>
        </form>
    </div>
</template>

<script>
    export default {
        name: "new"
    }
</script>

<style scoped>

</style>