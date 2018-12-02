# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_authenticity_token
  #
  # before_action :authenticate_user!, :redirect_unless_admin, only: [:new, :create]
  # skip_before_action :require_no_authentication

  clear_respond_to
  respond_to :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    success, user = User.valid_login?(params[:email], params[:password])
    if success
      sign_in(:user, user)
      render json: { notice: 'You have been successfully logged in.' },
             status: :created
    else
      head :unauthorized
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to do |format|
      format.json do
        render json: { notice: 'You have been successfully logged out.' },
               status: :ok
      end
    end
  end

  private

  def redirect_unless_admin
    head :unauthorized unless current_user.try(:admin?)
  end

  def sign_up(_resource_name, _resource)
    true
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
