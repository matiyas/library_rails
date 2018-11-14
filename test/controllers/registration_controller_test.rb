require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user0)
  end

  test 'should get new' do
    get new_user_registration_path
    assert_response :success
  end

  test 'should get edit when logged in' do
    sign_in @user
    get edit_user_registration_path
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get edit_user_registration_path
    assert_redirected_to new_user_session_path
  end
end
