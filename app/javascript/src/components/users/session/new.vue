<template>
    <layout>
        <form class="form-generic form-signin">
            <h2>Log in</h2>

            <div class="field">
                <input autofocus="autofocus"
                       autocomplete="email"
                       class="form-control"
                       placeholder="Email address"
                       type="email"
                       name="user[email]"
                       v-model="user.email">
            </div>

            <div class="field">
                <input autocomplete="current-password"
                       class="form-control"
                       placeholder="Password"
                       type="password"
                       name="user[password]"
                       v-model="user.password">
            </div>

            <div class="field checkbox mb-3">
                <input type="checkbox"
                       name="user[remember_me]"
                       true-value="1"
                       false-value="0"
                       v-model="user.remember_me">
                Remember me
            </div>

            <div class="actions">
                <input type="submit"
                       value="Log in"
                       class="btn btn-lg btn-primary btn-block"
                       v-on:click.prevent="sign_in">
            </div>
        </form>
    </layout>
</template>

<script>
    import axios from 'axios';
    import Layout from '../../shared/layout';
    import router from '../../../../routes';
    import store from '../../../../store';

    export default {
        name: "new",
        components: { Layout },
        data: function() {
            return {
                user: { email: '', password: '', remember_me: 0 },
                store
            }
        },
        methods: {
            sign_in: function () {
                axios.post('/api/users/sign_in/', {
                    email: this.user.email,
                    password: this.user.password,
                    remember_me: this.user.remember_me
                })
                .then(result => {
                    router.push({ name: 'root_path' });
                    this.flashSuccess(result.data.notice, { timeout: 3000 });
                    this.store.current_user = result.data.current_user;
                })
                .catch(() => {
                    this.flashError('Invalid email/password combination.', { timeout: 3000 });
                });
            },
        }
    }
</script>

<style scoped>

</style>