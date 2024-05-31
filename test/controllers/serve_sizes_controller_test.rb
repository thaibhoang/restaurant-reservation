# require "test_helper"

# class ServeSizesControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @serve_size = serve_sizes(:one)
#   end

#   test "should get index" do
#     get serve_sizes_url
#     assert_response :success
#   end

#   test "should get new" do
#     get new_serve_size_url
#     assert_response :success
#   end

#   test "should create serve_size" do
#     assert_difference("ServeSize.count") do
#       post serve_sizes_url, params: { serve_size: { dish_id: @serve_size.dish_id, name: @serve_size.name, price: @serve_size.price } }
#     end

#     assert_redirected_to serve_size_url(ServeSize.last)
#   end

#   test "should show serve_size" do
#     get serve_size_url(@serve_size)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_serve_size_url(@serve_size)
#     assert_response :success
#   end

#   test "should update serve_size" do
#     patch serve_size_url(@serve_size), params: { serve_size: { dish_id: @serve_size.dish_id, name: @serve_size.name, price: @serve_size.price } }
#     assert_redirected_to serve_size_url(@serve_size)
#   end

#   test "should destroy serve_size" do
#     assert_difference("ServeSize.count", -1) do
#       delete serve_size_url(@serve_size)
#     end

#     assert_redirected_to serve_sizes_url
#   end
# end
