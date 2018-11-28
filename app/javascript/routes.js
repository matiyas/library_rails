import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import UsersPosts from 'src/components/users/posts/index'
import ShowUserPost from 'src/components/users/posts/show'
import EditUserPost from 'src/components/users/posts/edit'


const router = new VueRouter({
    mode: 'history',
    routes: [
        { path: '/', component: UsersPosts, name: 'root_path' },
        { path: '/posts/:id', component: ShowUserPost, name: 'posts_path' },
        { path: '/posts/:id/edit', component: EditUserPost, name: 'edit_post_path' },
    ]
});

export default router;