require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "foo@bar.com", password: "foobar")
    @admin = User.create(email: "admin@foo.com", password: "admin", is_admin: true)
  end

  test "user can access index when logged in"do
    manual_sign_in_as(@user)
    get index_path
    assert_response :success
  end

  test "admin can access index" do
    manual_sign_in_as(@admin)
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

  test "admin not able to create room with missing room id" do
    room = Room.create(room_id: '', description: "Test", price: 50)
    assert_not room.save
  end

  test "admin not able to create room with no description" do
    room = Room.create(room_id: 10, description: "", price: 50)
    assert_not room.save
  end

  test "admin not able to create room with price less than zero" do
    room = Room.create(room_id: 10, description: "test", price: -30)
    assert_not room.save
  end

  test "test user cannot edit room when not logged in" do
    get '/rooms/edit'
    assert_response :redirect
  end

  test "user not signed in cannot access edit page" do
    get '/rooms/edit'
    assert_response :redirect
  end

  test "test regular user cannot edit room when not logged in" do
    manual_sign_in_as(@user)
    get '/rooms/edit'
    assert_response :redirect
  end

  test "admin is able to access edit room page" do
    manual_sign_in_as(@admin)
    get '/rooms/edit'
    assert_response :found
  end

  test "admin is able to edit room" do
    room = Room.new(room_id: 10, description: "test", price: 20)
    room.update(price: 30)
    assert_equal(room.price, 30)
  end


end
