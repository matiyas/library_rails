require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user0)
  end

  test "should not get show when not logged in" do
    get profile_url(@user)
    assert_redirected_to_login
  end
end
