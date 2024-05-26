class RestaurantProfilesController < ApplicationController
  before_action :authenticate_business!
  before_action :set_restaurant_profile, :owner_only, only: %i[show edit update]

  def show
  end

  # GET /restaurant_profiles/new
  def new
    @restaurant_profile = RestaurantProfile.new
  end

  # GET /restaurant_profiles/1/edit
  def edit
  end

  def create
    @restaurant_profile = current_business.build_restaurant_profile(restaurant_profile_params)

    respond_to do |format|
      if @restaurant_profile.save
        format.html do
          redirect_to restaurant_profile_url(@restaurant_profile), notice: "Restaurant profile was successfully created."
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurant_profile.update(restaurant_profile_params)
        format.html do
          redirect_to restaurant_profile_url(@restaurant_profile),
                      notice: "Restaurant profile was successfully updated." 
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant_profile
    @restaurant_profile = RestaurantProfile.find(params[:id])
  end

  def owner_only
    return if @restaurant_profile.business == current_business

    flash[:notice] = "You can only see your own restaurant's admin page"
    redirect_to current_business
  end

  # Only allow a list of trusted parameters through.
  def restaurant_profile_params
    params.require(:restaurant_profile).permit(:name,
                                               :description, :phone,
                                               :address, :hours_of_operation,
                                               :price, :cuisine, :dining_style,
                                               :dress_code, :parking_details,
                                               :payment_options, :executive_chef,
                                               :website, :catering,
                                               :private_party_facilities,
                                               :additional)
  end
end
