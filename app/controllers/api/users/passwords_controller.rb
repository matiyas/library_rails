# frozen_string_literal: true

class Api::Users::PasswordsController < Devise::PasswordsController
  respond_to :json

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      flash[:notice] = 'You will receive an email with instructions on how to' +
                       ' reset your password in a few minutes.'
      respond_to do |format|
        format.html { redirect_to new_user_session_url }
        format.json do
          render json: { url: new_user_session_url }, status: :ok
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json do
          render json: resource.errors.messages, status: :unprocessable_entity
        end
      end
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        flash[:notice] = find_message(flash_message)
        sign_in(resource_name, resource)
      else
        flash[:notice] = find_message(:updated_not_active)
      end
      respond_to do |format|
        format.html { redirect_to after_resetting_password_path_for(resource) }
        format.json do
          render json: { url: after_resetting_password_path_for(resource) }, status: :ok
        end
      end
    else
      set_minimum_password_length
      respond_to do |format|
        format.html { render :edit }
        format.json do
          render json: resource.errors.messages, status: :unprocessable_entity
        end
      end
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
