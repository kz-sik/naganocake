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
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    if params[:order][:select_address] = "0"
      @order = Order.new
      @order.payment = params[:order][:payment]
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] = "1"
      @order = Order.new
      @address = Address.find(params[:order][:address_id])
      @order.payment = params[:order][:payment]
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      @order = Order.new(order_params)
    end
  end

  def complete

  end

  def create

  end

  private

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name)
  end
end
