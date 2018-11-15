ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def user_logged_in?(user)
    !session['warden.user.user.key'].nil? &&
      session['warden.user.user.key'][0][0] == user.id
  end
end
