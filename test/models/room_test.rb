require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # This test ensures that a room can be created with valid parameters
  test "admin is able to create a new room with valid parameters" do
    room = Room.create(room_id: 1, description: "test", price: 20)
    assert room.save
  end

  # This test ensures that a room cannot be created without an id
  test "admin not able to create room with missing room id" do
    room = Room.create(room_id: '', description: "Test", price: 50)
    assert_not room.save
  end

  # This test ensures that a room cannot be created with a negative id
  test "admin not able to create room with id less than zero" do
    room = Room.create(room_id: -1, description: "test", price: 50)
    assert_not room.save
  end

  # This test ensures that a room cannot be created without a description
  test "admin not able to create room with no description" do
    room = Room.create(room_id: 10, description: "", price: 50)
    assert_not room.save
  end

  # This test ensures that a room cannot be created with a price less than zero
  test "admin not able to create room with price less than zero" do
    room = Room.create(room_id: 10, description: "test", price: -30)
    assert_not room.save
  end

  # This test ensures that a room cannot be created without a price parameter
  test "admin not able to create a room with no price" do
    room = Room.new(room_id:10, description: "test", price: '')
    assert_not room.save
  end

  # This test ensures that a room cannot be created without a number for a room id
  test "not able to create room without number" do
    room = Room.new(room_id: "test", description: "test", price: 4)
    assert_not room.save
  end

  # This test ensures that a room cannot be created without a number for a price
  test "not able to create room without numerical price" do
    room = Room.new(room_id: 10, description: "test", price: "test")
    assert_not room.save
  end
end
