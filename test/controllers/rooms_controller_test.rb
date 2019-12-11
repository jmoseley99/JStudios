require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  # Creating two user objects that can be used throughout testing, as only an admin should be able to edit any room information
  setup do
    @room = rooms(:one)
    @user = User.create(email: "foo@bar.com", password: "foobar")
    @admin = User.create(email: "admin@foo.com", password: "admin", is_admin: true)
  end

  # This test ensures that the user can access the rooms page when logged in
  test "user can access index when logged in"do
    manual_sign_in_as(@user)
    get index_path
    assert_response :success
    assert_select 'h1', "JStudios"
  end

  # This test ensures that an admin account can also access the rooms page
  test "admin can access index" do
    manual_sign_in_as(@admin)
    get index_path
    assert_response :success
  end

  # This test ensures that when nobody is logged in you can still view the rooms page
  test "user can access index when not logged in" do
    get index_path
    assert_response :success
  end

  # This test ensures that a regular user is not allowed to make a new room when not logged in
  test "user not able to create room when not logged in" do
    get new_room_path
    assert_response :redirect
  end

  # This test ensures that a regular user cannot have access to the new rooms form
  test "regular user cannot create rooms" do
    manual_sign_in_as(@user)
    get new_room_path
    assert_response :redirect
  end

  # This test ensures that a regular user is not allowed to make a new room when logged in
  test "user able to create room when logged in" do
    manual_sign_in_as(@admin)
    get new_room_path
    post rooms_url(params: { room: { room_id: 4, description: "Test Room Four", price: 25, created_at: DateTime.now, updated_at: DateTime.now } })
    assert_response :redirect
  end

  # This test ensures that the edit page cannot be accessed when not logged in
  test "test user cannot edit room when not logged in" do
    get '/rooms/edit'
    assert_response :redirect
  end

  # This test ensures that the edit room page cannot be accessed when not signed in
  test "user not signed in cannot access edit page" do
    get '/rooms/edit'
    assert_response :redirect
  end

  # This test ensures that a regular user cannot edit a room
  test "test regular user cannot edit room when not logged in" do
    manual_sign_in_as(@user)
    get '/rooms/edit'
    assert_response :redirect
  end

  # This test ensures that an admin is able to access the edit room page
  test "admin is able to access edit room page" do
    manual_sign_in_as(@admin)
    get '/rooms/edit'
    assert_response :found
  end

  # This test ensures that an admin is able to edit attributes attached to a room
  test "admin is able to edit room" do
    room = Room.new(room_id: 10, description: "test", price: 20)
    room.update(price: 30)
    assert_equal(room.price, 30)
  end

  # This test ensures that a regular user is not able to delete a room
  test "user not able to delete a room" do
    assert_difference 'Room.count', 0 do
      delete room_path(@room)
    end
  end


end
