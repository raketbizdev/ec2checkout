require "test_helper"

class StorefrontsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get storefronts_show_url
    assert_response :success
  end
end
