class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, :owner_only, only: %i[ show edit update destroy last_step ]
  before_action :set_business, :set_time, only: [:available]
  before_action :get_variables_from_session, only: %i[create select_seating]
  before_action :valid_update, only: %i[update last_step]

  # GET /reservations or /reservations.json
  def index
    @reservations = current_user.reservations
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = current_user.reservations.build(reservation_params)

    respond_to do |format|
      if @reservation.save
        # remove the reservation if after 5 minutes the status does not change from holded to booked
        ReservationRemoveHoldJob.set(wait: 5.minutes).perform_later(@reservation.id)
        format.html { redirect_to last_step_reservations_url(id: @reservation.id) }
      else
        format.html { render :select_seating, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(confirm_reservation_params)
        session[:reservation] = {}
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { redirect_to last_step_reservations_url(id: @reservation.id) }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    (redirect_to root_path && return) unless @reservation.status == "holded"
    @reservation.destroy!

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def available
    @target = params[:target]
    session[:business_id] = @business.id
    session[:reservation] = {}
    @party_size = params[:party_size]


    duration = @business.restaurant_profile.dining_duration
    @available_choices = Reservation.find_availabale_tables(@business.id, params[:party_size], @time, duration, @business.seating_options.pluck(:id))

    respond_to do |format|
      format.turbo_stream
    end
  end

  def select_seating
    @seating_option_objects = SeatingOption.find(@seating_options.to_a.map(&:first))
    @reservation = Reservation.new
  end

  def last_step
    @business_name = RestaurantProfile.find_by(business_id: @reservation.table.business_id).name
  end

  private

  def valid_update
    if @reservation.nil? || @reservation.status != "holded" || Time.current - @reservation.created_at > 5.minutes
      redirect_to root_path, alert: "Reservation expired or not found"
    end
  end

  def get_variables_from_session
    @token = params[:token]
    @party_size = session[:reservation][@token]["party_size"]
    @seating_options = session[:reservation][@token]["seating_options"]
    @time = DateTime.parse(session[:reservation][@token]["time"])
    @business_name = RestaurantProfile.find_by(business_id: session[:business_id]).name
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_business
    @business = Business.find(params[:business_id])
  end

  def set_time
    @time = Time.parse("#{params[:date]} #{params[:hour]}")
  end

  def owner_only
    redirect_to root_path unless @reservation.user == current_user
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:party_size, :time, :table_id)
  end

  # This is for changing the reservation status from holded to booked
  def confirm_reservation_params
    params.require(:reservation).permit(:status, :occation, :special_request)
  end
  
end
