require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  # This test makes sure that the contact path can be accessed by anybody
  test "should get contact" do
    get contacts_path
    assert_response :success
    assert_select 'h1', "Contact Us"
    assert_select 'p', "If you've had an issue with your booking, please email us using the form below"
  end

  # This test makes sure that a message can be sent by anybody
  test "should allow a contact form" do
    post contacts_path params: {name: "Jacob", email: "jacob@moseley.com", message:"Test Message"}
    assert_response :success
    assert_nil flash[:alert]
  end



end
