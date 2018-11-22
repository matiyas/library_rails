# frozen_string_literal: true

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user0)
  end

  test 'login with invalid fields' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: {
      user: { email: @user.email, password: '1234567' }
    }
    assert_template 'devise/sessions/new'
    assert_select 'div.alert'
    get root_path
    assert_select 'div.alert', 0
  end

  test 'login with valid fields following by logout' do
    # Log in
    get new_user_session_path
    assert_template 'devise/sessions/new'
    assert_select 'a[href=?]', new_user_session_path
    post user_session_path, params: {
      user: { email: @user.email, password: '123456', remember_me: false }
    }
    assert_not flash.empty?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'posts/index'
    assert user_logged_in?(@user)
    assert_select 'a[href=?]', destroy_user_session_path

    # Log out
    delete destroy_user_session_path
    assert_not user_logged_in?(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_template 'devise/sessions/new'
  end
end
