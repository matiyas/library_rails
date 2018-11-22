# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      flash[:notice] = 'You will receive an email with instructions for how' +
                        ' to confirm your email address in a few minutes.'
      respond_to do |format|
        format.json do
          render json: { url: after_resending_confirmation_instructions_path_for(resource_name) },
                 status: :ok
        end
      end
    else
      respond_to do |format|
        format.json do
          render json: resource.errors.messages, status: :unprocessable_entity
        end
      end
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
