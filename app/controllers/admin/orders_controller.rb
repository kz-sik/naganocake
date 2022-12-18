class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.order_status = params[:order][:order_status].to_i
    @order.update(order_status: @order.order_status)
    @order_details = @order.order_details.all
    @order_details.crafting_status = "1".to_i
    @order_details.update(crafting_status: @order_details.crafting_status)
    redirect_to admin_order_path(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :price, :payment, :order_status)
  end
end
