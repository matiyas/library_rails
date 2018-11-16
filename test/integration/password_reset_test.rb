require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user0)
    ActionMailer::Base.deliveries.clear
  end

  # test 'reset password' do
  #   # Send password reset request
  #   get new_user_password_path
  #   assert_template 'devise/passwords/new'
  #   post user_password_path, params: { user: { email: @user.email } }
  #   assert_redirected_to new_user_session_path
  #   follow_redirect!
  #   assert_template 'devise/sessions/new'
  #   assert_not flash.empty?
  #   assert_equal 1, ActionMailer::Base.deliveries.size
  #
  #   # Reset password with link
  #   get edit_user_password_path(
  #     reset_password_token: @user.reload.reset_password_token
  #   )
  #   assert_template 'devise/passwords/edit'
  #
  #   # Invalid password fields
  #   # put user_password_path, params: {
  #   #   user: {
  #   #     reset_password_token: @user.reset_password_token,
  #   #     password: '654321',
  #   #     password_confirmation: '123456'
  #   #   }
  #   # }
  #   # assert_errors_explanation
  #
  #   put user_password_path, params: {
  #     user: {
  #       reset_password_token: @user.reset_password_token,
  #       password: '654321',
  #       password_confirmation: '654321'
  #     }
  #   }
  #   puts response.body
  #   assert_redirected_to root_path
  #   assert_template 'posts/index'
  #   assert_not flash.empty?
  #   assert user_logged_in?
  # end
end
