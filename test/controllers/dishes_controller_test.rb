require "test_helper"

class DishesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:test_business)
    sign_in @business
    @group = groups(:one)
    @group2 = groups(:two)
    @dish = dishes(:one)
    @serve_size = serve_sizes(:one)
  end

  # group_id = @group.id
  test "should get index" do
    get dishes_url(group_id: @group.id)
    assert_response :success
  end

  test "should get new" do
    get new_dish_url(group_id: @group.id)
    assert_response :success
  end

  test "should create dish" do
    assert_difference("Dish.count") do
      assert_difference("ServeSize.count", 2) do
        post dishes_url(group_id: @group.id), params: { 
          dish: { 
            description: @dish.description,
            name: @dish.name,
            serve_sizes_attributes: {
              "0": {name: "Adult", price: 10},
              "1": {name: "Child", price: 5},
            }
          } 
        }
      end
    end

    assert_redirected_to dish_url(Dish.last, group_id: @group.id)
  end

  test "should show dish" do
    get dish_url(@dish, group_id: @group.id)
    assert_response :success
  end

  test "should get edit" do
    get edit_dish_url(@dish, group_id: @group.id)
    assert_response :success
  end

  test "should update dish" do
    patch dish_url(@dish, group_id: @group.id), params: { dish: { description: @dish.description, group_id: @dish.group_id, name: @dish.name } }
    assert_redirected_to dish_url(@dish, group_id: @group.id)
  end
  test "should update serve size along with dish" do
    assert_difference("ServeSize.count", 1) do
      patch dish_url(@dish, group_id: @group.id), params: { 
        dish: { 
          description: @dish.description,
          name: @dish.name,
          serve_sizes_attributes: {
            "0": {name: "Adult", price: 10},
          }
        } 
      }
    end
  end

  test "should destroy dish" do
    assert_difference("Dish.count", -1) do
      assert_difference("ServeSize.count", -1) do
        delete dish_url(@dish, group_id: @group.id)
      end
    end

    assert_redirected_to dishes_url(group_id: @group.id)
  end

  test "should not get index" do
    get dishes_url(group_id: @group2.id)
    assert_redirected_to menus_url
  end

  test "should not get new" do
    get new_dish_url(group_id: @group2.id)
    assert_redirected_to menus_url
  end

  test "should not create dish" do
    assert_difference("Dish.count",0) do
      post dishes_url(group_id: @group2.id), params: { dish: { description: @dish.description, group_id: @dish.group_id, name: @dish.name } }
    end

    assert_redirected_to menus_url
  end

  test "should not show dish" do
    get dish_url(@dish, group_id: @group2.id)
    assert_redirected_to menus_url
  end

  test "should not get edit" do
    get edit_dish_url(@dish, group_id: @group2.id)
    assert_redirected_to menus_url
  end

  test "should not update dish" do
    patch dish_url(@dish, group_id: @group2.id), params: { dish: { description: @dish.description, group_id: @dish.group_id, name: @dish.name } }
    assert_redirected_to menus_url
  end

  test "should not destroy dish" do
    assert_difference("Dish.count", 0) do
      delete dish_url(@dish, group_id: @group2.id)
    end

    assert_redirected_to menus_url
  end
end
