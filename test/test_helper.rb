ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  config.include ActiveSupport::Testing::TimeHelpers

  def manual_sign_in_as(user)
    post session_url, params: {
        session: {
            email: user.email,
            password: user.password
        }
    }
  end

end
