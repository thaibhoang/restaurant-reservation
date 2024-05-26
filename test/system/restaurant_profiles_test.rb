require "application_system_test_case"

class RestaurantProfilesTest < ApplicationSystemTestCase
  setup do
    @restaurant_profile = restaurant_profiles(:one)
  end

  test "visiting the index" do
    visit restaurant_profiles_url
    assert_selector "h1", text: "Restaurant profiles"
  end

  test "should create restaurant profile" do
    visit restaurant_profiles_url
    click_on "New restaurant profile"

    fill_in "Additional", with: @restaurant_profile.additional
    fill_in "Address", with: @restaurant_profile.address
    fill_in "Business", with: @restaurant_profile.business_id
    fill_in "Catering", with: @restaurant_profile.catering
    fill_in "Cuisine", with: @restaurant_profile.cuisine
    fill_in "Description", with: @restaurant_profile.description
    fill_in "Dining style", with: @restaurant_profile.dining_style
    fill_in "Dress code", with: @restaurant_profile.dress_code
    fill_in "Executive chef", with: @restaurant_profile.executive_chef
    fill_in "Hours of operation", with: @restaurant_profile.hours_of_operation
    fill_in "Name", with: @restaurant_profile.name
    fill_in "Parking details", with: @restaurant_profile.parking_details
    fill_in "Payment options", with: @restaurant_profile.payment_options
    fill_in "Phone", with: @restaurant_profile.phone
    fill_in "Price", with: @restaurant_profile.price
    fill_in "Private party facilities", with: @restaurant_profile.private_party_facilities
    fill_in "Website", with: @restaurant_profile.website
    click_on "Create Restaurant profile"

    assert_text "Restaurant profile was successfully created"
    click_on "Back"
  end

  test "should update Restaurant profile" do
    visit restaurant_profile_url(@restaurant_profile)
    click_on "Edit this restaurant profile", match: :first

    fill_in "Additional", with: @restaurant_profile.additional
    fill_in "Address", with: @restaurant_profile.address
    fill_in "Business", with: @restaurant_profile.business_id
    fill_in "Catering", with: @restaurant_profile.catering
    fill_in "Cuisine", with: @restaurant_profile.cuisine
    fill_in "Description", with: @restaurant_profile.description
    fill_in "Dining style", with: @restaurant_profile.dining_style
    fill_in "Dress code", with: @restaurant_profile.dress_code
    fill_in "Executive chef", with: @restaurant_profile.executive_chef
    fill_in "Hours of operation", with: @restaurant_profile.hours_of_operation
    fill_in "Name", with: @restaurant_profile.name
    fill_in "Parking details", with: @restaurant_profile.parking_details
    fill_in "Payment options", with: @restaurant_profile.payment_options
    fill_in "Phone", with: @restaurant_profile.phone
    fill_in "Price", with: @restaurant_profile.price
    fill_in "Private party facilities", with: @restaurant_profile.private_party_facilities
    fill_in "Website", with: @restaurant_profile.website
    click_on "Update Restaurant profile"

    assert_text "Restaurant profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Restaurant profile" do
    visit restaurant_profile_url(@restaurant_profile)
    click_on "Destroy this restaurant profile", match: :first

    assert_text "Restaurant profile was successfully destroyed"
  end
end
