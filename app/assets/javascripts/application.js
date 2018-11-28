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

    String.prototype.capitalize = function() {
        return this.charAt(0).toUpperCase() + this.slice(1);
    };

    String.prototype.removeExtension = function() {
        return this.replace(/\.[^/.]+$/, "");
    };

    function beforeSubmit() {
        $('.form-control').each(function(){
            $(this).removeClass('field_with_errors');
        });
    }

    function successResponse(response) {
        let url = response['url'].removeExtension();
         window.location = url;
    }

    function errorAction(response) {
        let alertMsg = '';
        $.each(response.responseJSON, function(field, errors){
            let field_name = "[name*='[" + field + "]']";
            $(field_name).addClass('field_with_errors');

            $.each(errors, function(error) {
                alertMsg += field.capitalize().replace('_', ' ') + ' ' + errors[error] + '</br>';
            })
        });

        $('.alert').remove();
        $('.container:first').prepend('<div class="alert alert-error">' + alertMsg + '</div>');
    }

    function errorSignInAction(response) {
        let alert = '<div class="alert alert-error">' + response.responseJSON['error'] + '</div>';
        $('.alert').remove();
        $('.container:first').prepend(alert);
    }

    $(':submit').removeAttr('data-disable-with');

    $('.form-post, .form-registration, .form-new-password-reset,' +
        '.form-edit-password-reset,.form-new-confirmation').ajaxForm(options);
    $('.form-signin').ajaxForm(signInOptions);
});

