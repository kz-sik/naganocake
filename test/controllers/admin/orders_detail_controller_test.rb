require "test_helper"

class Admin::OrdersDetailControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_orders_detail_update_url
    assert_response :success
  end
end
