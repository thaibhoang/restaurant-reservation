require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:test_business)
    sign_in @business
    @other = Business.last
  end

  test "should show business admin page when login" do
    get business_url(id: @business.id)
    assert_response :success
  end

  test "should get redirect if try to visit other business admin page" do
    get business_url(id: @other.id)
    assert_response :redirect
    follow_redirect!
    assert_match "You can only see your own restaurant", response.body
  end

  test "Logout business get redirected to login page" do
    sign_out :business
    get business_url(id: @business.id)
    assert_response :redirect
    follow_redirect!
    assert_match "You need to sign in or sign up before continuing", response.body
  end
end
