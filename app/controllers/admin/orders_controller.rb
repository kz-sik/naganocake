class Admin::OrdersController < ApplicationController
  def show
    @order = order.find(params.id)
  end

  def update
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :price, :payment, :order_status)
  end
end
