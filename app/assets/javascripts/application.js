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
//= require turbolinks
//= require_tree .

$(document).ready(function() {
    $(':submit').removeAttr('data-disable-with');

    let options = {
        success:       successResponse,
        beforeSubmit: beforeSubmit,
        error: showErrorResponse,
        dataType: 'json'
    };

    $('#new_post').ajaxForm(options);
    let form = '';

    function beforeSubmit(formData, jqForm) {
        form = jqForm[0].id;
    }

    function successResponse(response) {
        console.log('response');
        // window.location =
    }

    function capitalize(string) {
        return string.charAt(0).toUpperCase() + string.slice(1);
    }

    function showErrorResponse(response) {
        let json = JSON.parse(response.responseText);
        var alertMsg = '';

        jQuery.each(json, function(field, errors){
            let field_name = "[name*='[" + field + "]']";
            $(field_name).css('border', '2px solid #ff9e9e');
            console.log(errors);

            jQuery.each(errors, function (error) {
                alertMsg += capitalize(field) + ' ' + errors[error] + '\n';
            })
        });

        alert(alertMsg);
    }
});