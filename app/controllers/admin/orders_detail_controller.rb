class Admin::OrdersDetailController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(crafting_status: params[:order_detail][:crafting_status])
    if @order_detail.crafting_status == "in_production"
      @order = @order_detail.order
      @order.update(order_status: 2)
    end
    if @order_detail.order.order_details.count == @order_detail.order.order_details.where(crafting_status: 3).count
      @order = @order_detail.order
      @order.update(order_status: 3)
    end
    redirect_to admin_order_path(params[:order_id])
  end
end
