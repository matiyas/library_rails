# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  clear_respond_to
  respond_to :json

  # POST /resource/sign_in
  def create
    success, user = User.valid_login?(params[:email], params[:password])
    if success
      sign_in(:user, user)
      if Devise::TRUE_VALUES.include?(params[:remember_me])
        user.remember_me!
        cookies.signed[:remember_user_token] = {
          value: user.class.serialize_into_cookie(user.reload),
          expires: user.class.remember_for.from_now
        }
      end
      render json: {
        notice: 'You have been successfully logged in.',
        current_user: { name: current_user.name, id: current_user.id }
      },
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

end
