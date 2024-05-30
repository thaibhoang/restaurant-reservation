require "application_system_test_case"

class ServeSizesTest < ApplicationSystemTestCase
  setup do
    @serve_size = serve_sizes(:one)
  end

  test "visiting the index" do
    visit serve_sizes_url
    assert_selector "h1", text: "Serve sizes"
  end

  test "should create serve size" do
    visit serve_sizes_url
    click_on "New serve size"

    fill_in "Dish", with: @serve_size.dish_id
    fill_in "Name", with: @serve_size.name
    fill_in "Price", with: @serve_size.price
    click_on "Create Serve size"

    assert_text "Serve size was successfully created"
    click_on "Back"
  end

  test "should update Serve size" do
    visit serve_size_url(@serve_size)
    click_on "Edit this serve size", match: :first

    fill_in "Dish", with: @serve_size.dish_id
    fill_in "Name", with: @serve_size.name
    fill_in "Price", with: @serve_size.price
    click_on "Update Serve size"

    assert_text "Serve size was successfully updated"
    click_on "Back"
  end

  test "should destroy Serve size" do
    visit serve_size_url(@serve_size)
    click_on "Destroy this serve size", match: :first

    assert_text "Serve size was successfully destroyed"
  end
end
