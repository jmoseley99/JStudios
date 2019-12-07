require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get contact" do
    get '/contacts'
      assert_response :success
  end

  test "test valid contact message" do
    assert Contact.new(name: "Jacob", email: "jacob.@gmail.com", message: "Test msg!", nickname: "").save
  end

  test "test invalid no name" do
    assert_not Contact.new(name: "", email: "jacob@gmail.com", message: "Test msg!", nickname: "").save
  end



end
