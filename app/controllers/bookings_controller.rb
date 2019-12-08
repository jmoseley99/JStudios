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
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
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
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
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
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # White list of parameters used to create a booking
    def booking_params
      params.require(:booking).permit(:date, :time, :room_id, :user_id, :duration)
    end
end
