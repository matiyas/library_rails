require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test 'should get new session' do
    get new_user_session_path
    assert_response :success
  end
end
