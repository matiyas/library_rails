<script>
    import Vue from 'vue/dist/vue.esm.js';

    Vue.mixin({
        methods: {
            setFieldsWithErrors: function(errors) {
                String.prototype.capitalize = function() {
                    return this.charAt(0).toUpperCase() + this.slice(1);
                };

                String.prototype.removeExtension = function() {
                    return this.replace(/\.[^/.]+$/, "");
                };

                $('.form-control').each(function(){
                    $(this).removeClass('field_with_errors');
                });

                let alertMsg = '';
                $.each(errors, function(field, error){
                    let field_name = "[name*='[" + field + "]']";
                    $(field_name).addClass('field_with_errors');

                    $.each(error, function(index) {
                        alertMsg += field.capitalize().replace('_', ' ') + ' ' + error[index] + '</br>';
                    })
                });

                this.flash().destroyAll();
                this.flashError(alertMsg, { timeout: 3000 });
            }
        }
    });

    export default {}
</script>
