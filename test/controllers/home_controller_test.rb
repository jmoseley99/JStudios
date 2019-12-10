require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get index_path
    assert_response :success
    assert_select 'h1', "JStudios"
    assert_select 'h2', "Welcome to our music studios! To get started, please sign in"
  end

end
