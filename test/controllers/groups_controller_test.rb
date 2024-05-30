require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:test_business)
    sign_in @business
    @menu = menus(:one)
    @group = groups(:one)
    @other_menu = menus(:two)
  end

  test "should get index" do
    get groups_url(menu_id: @menu.id)
    assert_response :success
  end

  test "should not get index" do
    get groups_url(menu_id: @other_menu.id)
    assert_response :redirect
    assert_redirected_to menus_url
  end

  test "should get new" do
    get new_group_url(menu_id: @menu.id)
    assert_response :success
  end

  test "should not get new" do
    get new_group_url(menu_id: @other_menu.id)
    assert_redirected_to menus_url
  end

  test "should create group" do
    assert_difference("Group.count") do
      post groups_url(menu_id: @menu.id), params: { group: { menu_id: @group.menu_id, name: @group.name } }
    end

    assert_redirected_to group_url(Group.last, menu_id: @menu.id)
  end

  test "should not create group" do
    assert_difference("Group.count", 0) do
      post groups_url(menu_id: @other_menu.id), params: { group: { menu_id: @group.menu_id, name: @group.name } }
    end

    assert_redirected_to menus_url
  end

  test "should show group" do
    get group_url(@group, menu_id: @menu.id)
    assert_response :success
  end

  test "should not show group" do
    get group_url(@group, menu_id: @other_menu.id)
    assert_redirected_to menus_url
  end

  test "should get edit" do
    get edit_group_url(@group, menu_id: @menu.id)
    assert_response :success
  end

  test "should not get edit" do
    get edit_group_url(@group, menu_id: @other_menu.id)
    assert_redirected_to menus_url
  end

  test "should update group" do
    patch group_url(@group, menu_id: @menu.id), params: { group: { menu_id: @group.menu_id, name: @group.name } }
    assert_redirected_to group_url(@group, menu_id: @menu.id)
  end

  test "should not update group" do
    patch group_url(@group, menu_id: @other_menu.id), params: { group: { menu_id: @group.menu_id, name: @group.name } }
    assert_redirected_to menus_url
  end

  test "should destroy group" do
    assert_difference("Group.count", -1) do
      delete group_url(@group, menu_id: @menu.id)
    end

    assert_redirected_to groups_url(menu_id: @menu.id)
  end

  test "should not destroy group" do
    assert_difference("Group.count", 0) do
      delete group_url(@group, menu_id: @other_menu.id)
    end

    assert_redirected_to menus_url
  end
end

class GroupsControllerNotLoginTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:test_business)
    @menu = menus(:one)
    @group = groups(:one)
  end

  test "should not get index" do
    get groups_url(menu_id: @menu.id)
    assert_redirected_to new_business_session_url
  end

  test "should not get new" do
    get new_group_url(menu_id: @menu.id)
    assert_redirected_to new_business_session_url
  end

  test "should not create group" do
    assert_difference("Group.count", 0) do
      post groups_url(menu_id: @menu.id), params: { group: { menu_id: @group.menu_id, name: @group.name } }
    end

    assert_redirected_to new_business_session_url
  end

  test "should not show group" do
    get group_url(@group, menu_id: @menu.id)
    assert_redirected_to new_business_session_url
  end

  test "should nto get edit" do
    get edit_group_url(@group, menu_id: @menu.id)
    assert_redirected_to new_business_session_url
  end

  test "should not update group" do
    patch group_url(@group, menu_id: @menu.id), params: { group: { menu_id: @group.menu_id, name: @group.name } }
    assert_redirected_to new_business_session_url
  end

  test "should not destroy group" do
    assert_difference("Group.count", 0) do
      delete group_url(@group, menu_id: @menu.id)
    end

    assert_redirected_to new_business_session_url
  end
end

