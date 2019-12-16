require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  # This test ensures that the home path is accessible and the correct view is loaded
  test "should get index" do
    get index_path
    assert_response :success
    assert_select 'h1', "JStudios"
    assert_select 'h2', "Welcome to our music studios! To get started, please sign in"
    assert_select 'title', "JStudios"
  end

end
