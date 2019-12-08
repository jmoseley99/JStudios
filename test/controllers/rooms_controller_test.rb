require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "foo@bar.com", password: "foobar")
  end

  test "user can access index when logged in"do
    manual_sign_in_as(@user)
    get index_path
    assert_response :success
  end

  test "user can access index when not logged in" do
    get index_path
    assert_response :success
  end

  # This test ensures that a regular user is not allowed to make a new room when not logged in
  test "user not able to create room when not logged in" do
    get new_room_path
    assert_response :redirect
  end

  # This test ensures that a regular user is not allowed to make a new room when logged in
  test "user able to create room when logged in" do
    manual_sign_in_as(@user)
    get new_room_path
    post rooms_url(params: { room: { room_id: 4, description: "Test Room Four", created_at: DateTime.now, updated_ad: DateTime.now, price: 25 } })
    assert_response :redirect
  end



end
