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
    assert_select 'h1', "Your Bookings"
    assert_select 'p', "Here you can find the bookings you've made in our studios! You can choose to show, edit or delete your bookings with the help of the buttons!"
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
    assert_response :found
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

  # Test that the price totalling method works correctly
  test "show total prices of bookings" do
    manual_sign_in_as(@user)
    get '/bookings/new'
    post bookings_url(as: @user), params: { booking: { date:Date.today, time:@time.strftime("%H:%M"), room_id:1, user_id:@user.id, duration:60 } }
    assert_equal(60, @controller.send(:get_total_spent))
  end

end
