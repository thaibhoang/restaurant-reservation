require "application_system_test_case"

class SeatingOptionsTest < ApplicationSystemTestCase
  setup do
    @seating_option = seating_options(:one)
  end

  test "visiting the index" do
    visit seating_options_url
    assert_selector "h1", text: "Seating options"
  end

  test "should create seating option" do
    visit seating_options_url
    click_on "New seating option"

    fill_in "Business", with: @seating_option.business_id
    fill_in "Name", with: @seating_option.name
    click_on "Create Seating option"

    assert_text "Seating option was successfully created"
    click_on "Back"
  end

  test "should update Seating option" do
    visit seating_option_url(@seating_option)
    click_on "Edit this seating option", match: :first

    fill_in "Business", with: @seating_option.business_id
    fill_in "Name", with: @seating_option.name
    click_on "Update Seating option"

    assert_text "Seating option was successfully updated"
    click_on "Back"
  end

  test "should destroy Seating option" do
    visit seating_option_url(@seating_option)
    click_on "Destroy this seating option", match: :first

    assert_text "Seating option was successfully destroyed"
  end
end
