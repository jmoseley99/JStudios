class BookingsController < ApplicationController

  # Making sure the user is logged in before accessing certain partials
  before_action :require_login, only: [:new, :destroy, :show]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  # GET /bookings
  def index
    @bookings = Booking.all
    # Making sure the user is logged in. If not, they are redirected to the sign up page
    if current_user.nil?
      redirect_to '/sign_up'
      flash[:error] ="Please sign in to book"
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  # Making a new booking
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit

  end
  # POST /bookings
  # POST /bookings.json
  # Letting a user make a new booking. If the booking is successful, the user will be notified, if not, there will
  # be an error displayed
  def create

    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save
        format.html { redirect_to bookings_path(@booking), notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  # This allows the user to update a pre-existing booking. If successful, the user will be notified.
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to bookings_path(@booking), notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  # This allows the user to delete a booking they have previously made. If successful, they will be notified
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_path(@booking), notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # This method allows the user to see how much they have spent in total, and is reloaded every time the page is refreshed
  # So after a new booking, the page is reloaded and the new total cost is worked out
  def get_total_spent
    @total = 0
    @user_bookings = Booking.where(:user_id => current_user.id)
    @user_bookings.each do |usr|
      @temp_room = Room.where(:room_id => usr.room_id)
      @temp_room.each do |room|
        @total = @total + room.price
      end
    end
    return @total
  end
  helper_method :get_total_spent


  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # White list of parameters used to create a booking
    def booking_params
      params.require(:booking).permit(:date, :time, :room_id, :user_id, :duration)
    end
end
