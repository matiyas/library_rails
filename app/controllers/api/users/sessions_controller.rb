# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    flash[:notice] = find_message(:signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_to do |format|
      format.html { redirect_to after_sign_in_path_for(resource) }
      format.json { render json: { url: after_sign_in_path_for(resource) } }
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to do |format|
      format.html { redirect_to new_user_session_path }
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
