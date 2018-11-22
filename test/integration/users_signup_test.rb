# frozen_string_literal: true

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'signup with valid fields followed by' +
       'resend confirmation and activation' do
    # Sign up
    get new_user_registration_path
    assert_template 'users/registrations/new'
    assert_difference 'User.count', 1 do
      post user_registration_path, params: {
        user: {
          email: 'new-user@example.com',
          name: 'New User',
          password: '123456',
          password_confirmation: '123456'
        }
      }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_not flash.empty?
    user = User.find_by(email: 'new-user@example.com')
    assert user.confirmed_at.nil?

    # Resend confirmation with invalid email
    get new_user_confirmation_path
    assert_template 'devise/confirmations/new'
    post user_confirmation_path, params: { user: { email: '' } }
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_template 'devise/confirmations/new'
    assert_errors_explanation

    # Resend confirmation with valid email
    post user_confirmation_path, params: { user: { email: user.email } }
    assert_equal 2, ActionMailer::Base.deliveries.size

    # Activation
    get user_confirmation_path(confirmation_token: user.confirmation_token)
    assert_redirected_to new_user_session_path
    assert_not flash.empty?
    assert_not user.reload.confirmed_at.nil?
  end

  test 'signup with invalid fields' do
    assert_no_difference 'User.count' do
      post user_registration_path, params: {
        user: {
          email: '',
          name: '',
          password: '',
          password_confirmation: ''
        }
      }
    end
    assert_template 'users/registrations/new'
    assert_errors_explanation
  end
end
