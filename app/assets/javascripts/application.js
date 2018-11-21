// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .

$(document).ready(function() {
    let options = {
        success: successResponse,
        beforeSubmit: beforeSubmit,
        error: errorAction,
        dataType: 'json'
    };

    let signInOptions = {
        success: successResponse,
        beforeSubmit: beforeSubmit,
        error: errorSignInAction,
        dataType: 'json'
    };

    function capitalize(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }

    function removeExtension(string) {
        return string.replace(/\.[^/.]+$/, "");
    }

    function beforeSubmit() {
        $('.form-control').each(function(){
            $(this).removeClass('field_with_errors');
        });
    }

    function successResponse(response) {
        let url = removeExtension(response['url']);
        window.location = url;
    }

    function errorAction(response) {
        let alertMsg = '';
        jQuery.each(response.responseJSON, function(field, errors){
            let field_name = "[name*='[" + field + "]']";
            $(field_name).addClass('field_with_errors');

            jQuery.each(errors, function(error) {
                alertMsg += capitalize(field).replace('_', ' ') + ' ' + errors[error] + '\n';
            })
        });

        alert(alertMsg);
    }

    function errorSignInAction(response) {
        alert(response.responseJSON['error']);
    }

    $(':submit').removeAttr('data-disable-with');

    $('.form-post').ajaxForm(options);
    $('.form-registration').ajaxForm(options);
    $('.form-signin').ajaxForm(signInOptions);
});

