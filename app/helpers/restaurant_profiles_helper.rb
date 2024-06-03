module RestaurantProfilesHelper

  def restaurant_nav_link
    if current_business.restaurant_profile.nil? || current_business.restaurant_profile.id.nil?
      new_restaurant_profile_path
    else
      restaurant_profile_path(current_business.restaurant_profile)
    end
  end

  def hours_of_operation(opening_hour, closing_hour)
    "From #{format_time opening_hour} To #{format_time closing_hour}"
  end
end
