require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  setup do
    @user = User.create(email: "foo@bar.com", password: "foobar")
    @time = Time.zone.local(2019, 12, 07, 9, 0)
  end

  # This test ensures a booking can be made with all correct parameters
  test "user can create a regular booking" do
    booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: 60)
    assert booking.save
  end
  # Test the user cannot create a booking with no time as it should be present
  test "user should not be able to create a booking without a time" do
    booking = Booking.new(date: Date.today, time: "", room_id: 1, user_id: @user.id, duration: 60)
    assert_not booking.save
  end

  # Test the user cannot create a booking with no room_id as it should be present to align with the database constraints
  test "user should not be able to create a booking without a room id" do
    booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: '', user_id: @user.id, duration: 60)
    assert_not booking.save
  end

  # Test the user cannot create a booking with no user as it should be present to align with the database constraints
  test "user should not be able to create a booking without a user attached to it" do
    booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: 3, user_id: '', duration: 60)
    assert_not booking.save
  end

  # Test the user cannot create a booking with no duration as it should be present
  test "user should not be able to create a booking without a duration" do
    booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: '')
    assert_not booking.save
  end

  # Test the user cannot create a booking with no date as it should be present
  test "user should not be able to create a booking without a date" do
    booking = Booking.new(date: "", time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: 60)
    assert_not booking.save
  end

  # Test the user cannot create a booking where the date is in the past
  test "user should not be able to create a booking in the past" do
    booking = Booking.new(date: Date.yesterday, time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: 60)
    assert_not booking.save
  end

  # Test that no two bookings can occur in the same room at the same time
  test "user should not be able to create two bookings at the same time" do
    legal_booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: 60)
    legal_booking.save
    illegal_booking = booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: 60)
    assert_not illegal_booking.save
  end

end
