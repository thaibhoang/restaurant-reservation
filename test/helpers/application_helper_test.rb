require "test_helper"
class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "OpenTable", full_title
    assert_equal "Home | OpenTable", full_title("Home")
  end

  test "show active" do
    assert_equal "active", show_active("Home", "Home")
    assert_equal "", show_active("Home", "About Us")
  end
end
