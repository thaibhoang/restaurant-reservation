module RestaurantProfilesHelper
  def restaurant_nav_link
    if current_business.restaurant_profile.nil?
      new_restaurant_profile_path
    else
      restaurant_profile_path(current_business.restaurant_profile)
    end
  end
end
