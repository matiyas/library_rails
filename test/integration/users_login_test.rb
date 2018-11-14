# frozen_string_literal: true

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user0)
  end

  test 'login with invalid fields' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: {
      user: { email: '', password: '' }
    }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  # test 'login with valid fields' do
  #   get new_user_session_path
  #   assert_template 'devise/sessions/new'
  #   post user_session_path, params: {
  #     user: { email: @user.email, password: @user.password }
  #   }
  #   # flash.each do |key, value|
  #   #   puts key, value
  #   # end
  # end
end
