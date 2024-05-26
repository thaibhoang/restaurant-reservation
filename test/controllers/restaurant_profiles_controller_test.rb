require "test_helper"

class BaseRestaurantProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:test_business)
    @other_restaurant_profile = restaurant_profiles(:two)
    @restaurant_profile = restaurant_profiles(:one)
  end

  test "should not show restaurant_profile when not login" do
    get restaurant_profile_url(@restaurant_profile)
    assert_response :redirect
    follow_redirect!
    assert_match "You need to sign in or sign up before continuing", response.body
  end

  test "should not show other restaurant_profile if not the owner" do
    sign_in @business
    get restaurant_profile_url(@other_restaurant_profile)
    assert_response :redirect
    follow_redirect!
    assert_match "You can only see your own restaurant", response.body
  end

  test "should not get new" do
    get new_restaurant_profile_url
    assert_response :redirect
    follow_redirect!
    assert_match "You need to sign in or sign up before continuing", response.body
  end

  test "should not get edit" do
    get edit_restaurant_profile_url(@restaurant_profile)
    assert_response :redirect
    follow_redirect!
    assert_match "You need to sign in or sign up before continuing", response.body
  end

  test "should not get edit of other restaurant_profile if not the owner" do
    sign_in @business
    get edit_restaurant_profile_url(@other_restaurant_profile)
    assert_response :redirect
    follow_redirect!
    assert_match "You can only see your own restaurant", response.body
  end
end

class RestaurantProfilesControllerLoginTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:test_business)
    @restaurant_profile = restaurant_profiles(:one)
    sign_in @business
  end

  test "should get new" do
    get new_restaurant_profile_url
    assert_response :success
  end

  test "should create restaurant_profile" do
    RestaurantProfile.delete_all
    assert_difference("RestaurantProfile.count") do
      post restaurant_profiles_url, params: { restaurant_profile: { additional: @restaurant_profile.additional,
                                                                    address: @restaurant_profile.address,
                                                                    catering: @restaurant_profile.catering,
                                                                    cuisine: @restaurant_profile.cuisine,
                                                                    description: @restaurant_profile.description,
                                                                    dining_style: @restaurant_profile.dining_style,
                                                                    dress_code: @restaurant_profile.dress_code,
                                                                    executive_chef: @restaurant_profile.executive_chef,
                                                                    hours_of_operation: @restaurant_profile.hours_of_operation,
                                                                    name: @restaurant_profile.name,
                                                                    parking_details: @restaurant_profile.parking_details,
                                                                    payment_options: @restaurant_profile.payment_options,
                                                                    phone: @restaurant_profile.phone,
                                                                    price: @restaurant_profile.price,
                                                                    private_party_facilities: @restaurant_profile.private_party_facilities,
                                                                    website: @restaurant_profile.website } }
    end

    assert_redirected_to restaurant_profile_url(RestaurantProfile.last)
  end

  test "should show restaurant_profile" do
    get restaurant_profile_url(@restaurant_profile)
    assert_response :success
    assert_match "Edit this restaurant profile", response.body
  end

  test "should get edit" do
    get edit_restaurant_profile_url(@restaurant_profile)
    assert_response :success
    assert_match "Editing restaurant profile", response.body
  end

  test "should update restaurant_profile" do
    patch restaurant_profile_url(@restaurant_profile),
          params: {
            restaurant_profile: {
              additional: @restaurant_profile.additional, address: @restaurant_profile.address,
              catering: @restaurant_profile.catering,
              cuisine: @restaurant_profile.cuisine, description: @restaurant_profile.description,
              dining_style: @restaurant_profile.dining_style, dress_code: @restaurant_profile.dress_code,
              executive_chef: @restaurant_profile.executive_chef, 
              hours_of_operation: @restaurant_profile.hours_of_operation, name: @restaurant_profile.name,
              parking_details: @restaurant_profile.parking_details,
              payment_options: @restaurant_profile.payment_options, phone: @restaurant_profile.phone,
              price: @restaurant_profile.price,
              private_party_facilities: @restaurant_profile.private_party_facilities,
              website: @restaurant_profile.website
            }
          }
    assert_redirected_to restaurant_profile_url(@restaurant_profile)
  end
end
