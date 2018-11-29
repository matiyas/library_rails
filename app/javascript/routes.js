import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import UsersPosts from 'src/components/users/posts/index'
import ShowUserPost from 'src/components/users/posts/show'
import EditUserPost from 'src/components/users/posts/edit'
import NewUserPost from 'src/components/users/posts/new'
import UsersProfile from 'src/components/users/profile'


const router = new VueRouter({
    mode: 'history',
    routes: [
        { path: '/', component: UsersPosts, name: 'root_path' },
        { path: '/users/posts/:id', component: ShowUserPost, name: 'posts_path' },
        { path: '/users/posts/:id/edit', component: EditUserPost, name: 'edit_post_path' },
        { path: '/users/posts/new', component: NewUserPost, name: 'new_post_path' },
        { path: '/users/profiles/:id', component: UsersProfile, name: 'user_profile_path' },
    ]
});

export default router;