class Admin::OrdersDetailController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(crafting_status: params[:order_detail][:crafting_status])
    redirect_to admin_order_path(params[:order_id])
  end
end
