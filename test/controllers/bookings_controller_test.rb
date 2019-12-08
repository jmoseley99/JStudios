require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  #This setup ensures that we have a saved booking object from the fixtures, a user object as it is required that the user is signed in
  # as well as a time object to avoid strange errors when using the ruby Time object
  setup do
    @booking = bookings(:one)
    @user = User.create(email: "foo@bar.com", password: "foobar")
    @time = Time.zone.local(2019, 12, 07, 9, 0)
  end

  # Test that the user is able to view the bookings page when they are logged in
  test "user able to view the page whilst logged in" do
    manual_sign_in_as(@user)
    get '/bookings'
    assert_response :success
  end

  # Test that the user is not able to view the bookings page when not logged in
  test "user not able to view page when not logged in" do
    get '/bookings'
    assert_response :redirect
  end

  # Test that the user is able to see bookings when they are signed in
  test "get show action" do
    manual_sign_in_as(@user)
    get booking_path(@booking)
    assert_response :success
  end

  # Test that the user is not able to see bookings when not signed in
  test "not able to get show action as not signed in" do
    get booking_path(@booking)
    assert_response :redirect
  end

  # Test that the user can create a new booking when signed in
  test 'user should be able to create a new booking'do
    manual_sign_in_as(@user)
    get '/bookings/new'
    post bookings_url(as: @user), params: { booking: { date:Date.today, time:@time.strftime("%H:%M"), room_id:1, user_id:@user.id, duration:60 } }
    assert_response :success
  end

  # Test the user cannot create a booking with no date as it should be present
  test "user should not be able to create a booking without a date" do
    booking = Booking.new(date: "", time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: 60)
    assert_not booking.save
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

  # Test the user cannot create a booking with a duration that is not 30 or 60 minutes, as stated by the model validations
  test "user should not be able to create a booking without a valid duration" do
    booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: 45)
    assert_not booking.save
  end

  # Test the user cannot create a booking with no duration as it should be present
  test "user should not be able to create a booking without a duration" do
    booking = Booking.new(date: Date.today, time: @time.strftime("%H:%M"), room_id: 1, user_id: @user.id, duration: '')
    assert_not booking.save
  end

  # Test that the user cannot create a new booking as they are not signed in
  test "user cannot make new booking as not signed in" do
    get new_booking_path
    assert_response :redirect
  end

  # Test that the user can delete a booking when they are signed in
  test "destroy booking whilst signed in" do
    manual_sign_in_as(@user)
    assert_difference 'Booking.count', -1 do
      delete booking_path(@booking)
    end
  end

  # Test that the user cannot delete a booking as they are not signed in, so have no bookings to delete
  test "try to destroy booking when not signed in" do
    assert_difference 'Booking.count', 0 do
      delete booking_path(@booking)
    end
  end

  # Test that the user can update a booking they have previously made when signed in
  test "update booking whilst signed in" do
    manual_sign_in_as(@user)
    booking = Booking.new(date:Date.today, time:@time.strftime("%H:%M"), room_id:1, user_id:@user.id, duration:60)
    booking.update(duration: 30)
    assert_equal(booking.duration, 30)
  end

end
