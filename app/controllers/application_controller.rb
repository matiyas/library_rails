class ApplicationController < ActionController::Base
  require 'will_paginate/array'

  before_action :authenticate_user!

  private

  def current_ability
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').camelize
    Ability.new(current_user, controller_namespace)
  end
end
