require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "OpenTable"
  end

  test "should get to home page" do
    get root_path
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
    assert_select "a.active", text: "Home"
    get for_business_path
    assert_select "title", "Business | #{@base_title}"
    assert_select "a.active", text: "For Businesses"
  end

  test "should get to business page" do
    get for_business_path
    assert_response :success
    assert_select "title", "Business | #{@base_title}"
    assert_select "a.active", text: "For Businesses"
  end

  test "should get to about us page" do
    get about_us_path
    assert_response :success
    assert_select "title", "About Us | #{@base_title}"
    assert_select "a.active", text: "About Us"
  end
end
