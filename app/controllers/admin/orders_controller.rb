class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_status: params[:order][:order_status])
    if @order.order_status == "payment_confirmation"
      @order_details = @order.order_details
      @order_details.update(crafting_status: 1)
    end
    redirect_to admin_order_path(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :price, :payment, :order_status)
  end
end
