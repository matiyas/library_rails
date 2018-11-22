# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def new
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   render :edit
  # end

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        flash[:notice] = find_message(:signed_up)
        sign_up(resource_name, resource)
        respond_to do |format|
          format.html { redirect_to after_sign_up_path_for(resource) }
          format.json do
            render json: { url: after_sign_up_path_for(resource) },
                   status: :ok
          end
        end
      else
        flash[:notice] = find_message(:"signed_up_but_#{resource.inactive_message}")
        expire_data_after_sign_in!
        respond_to do |format|
          format.html { redirect_to new_user_session_path }
          format.json do
            render json: { url: new_user_session_path },
                   status: :ok
          end
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.html { render :new }
        format.json do
          render json: resource.errors.messages,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      flash_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                    :update_needs_confirmation
                  else
                    :updated
                  end
      flash[:notice] = find_message(flash_key)
      bypass_sign_in resource, scope: resource_name
      respond_to do |format|
        format.html { redirect_to profile_url(resource) }
        format.json { render json: { url: profile_url(resource) }, status: :ok }
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: resource.errors.messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end


  protected


  def set_user
    @user = User.find(params[:id])
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def account_update_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :current_password)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
