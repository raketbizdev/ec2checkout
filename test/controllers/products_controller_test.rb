require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_index_url
    assert_response :success
  end

  test "should get edit" do
    get products_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get products_destroy_url
    assert_response :success
  end
end
