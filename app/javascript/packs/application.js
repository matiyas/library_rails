/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue.esm.js'
import router from '../routes'
import Gravatar from 'vue-gravatar'
import setupCSRFToken from '../setupCSRFToken'
import NavBar from '../src/components/shared/nav_bar'
import Layout from '../src/components/shared/layout'
import PostForm from '../src/components/users/posts/_form'


$(window).on('load', function () {
    setupCSRFToken();

    Vue.component('gravatar', Gravatar);
    Vue.component('nav-bar', NavBar);
    Vue.component('layout', Layout);
    Vue.component('post-form', PostForm);

    const app = new Vue({
        router
    }).$mount("#app");

    window.addEventListener('popstate', () => {
        app.currentRoute = window.location.pathname
    })

});
