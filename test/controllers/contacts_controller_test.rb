require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get contact" do
    get contacts_path
    assert_response :success
  end


end
