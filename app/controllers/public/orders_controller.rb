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
    @order.postage = 800
    @order.price = @order.postage + @total
  end

  def complete

  end

  def create
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
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
    @order.price = @order.postage + @total
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = catr.item.amount
        order_detail.price = cart.item.price
        order_detail.save
      end
      redirect_to orders_complete_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
    
  end

  private

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name)
  end
end
