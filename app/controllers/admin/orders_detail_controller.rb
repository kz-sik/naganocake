class Admin::OrdersDetailController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @order_details.crafting_status = params[:order_details][:crafting_status].to_i
    @order_details.update(crafting_status: @order_details.crafting_status)
    redirect_to admin_order_path(params[:id])
  end
end
