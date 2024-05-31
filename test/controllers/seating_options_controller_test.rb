require "test_helper"

class SeatingOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seating_option = seating_options(:one)
  end

  test "should get index" do
    get seating_options_url
    assert_response :success
  end

  test "should get new" do
    get new_seating_option_url
    assert_response :success
  end

  test "should create seating_option" do
    assert_difference("SeatingOption.count") do
      post seating_options_url, params: { seating_option: { business_id: @seating_option.business_id, name: @seating_option.name } }
    end

    assert_redirected_to seating_option_url(SeatingOption.last)
  end

  test "should show seating_option" do
    get seating_option_url(@seating_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_seating_option_url(@seating_option)
    assert_response :success
  end

  test "should update seating_option" do
    patch seating_option_url(@seating_option), params: { seating_option: { business_id: @seating_option.business_id, name: @seating_option.name } }
    assert_redirected_to seating_option_url(@seating_option)
  end

  test "should destroy seating_option" do
    assert_difference("SeatingOption.count", -1) do
      delete seating_option_url(@seating_option)
    end

    assert_redirected_to seating_options_url
  end
end
