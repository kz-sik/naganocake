class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
  end

  def show
  end

  def comfirm

  end

  def complete

  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    

  end
  
  private
  
  def order_params
    params.require(:order).permit()
  end
end
