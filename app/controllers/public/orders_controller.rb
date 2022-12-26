class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def comfirm
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    if params[:order][:select_address] = "0"
      @order = Order.new
      @order.payment = params[:order][:payment]
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
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
    #order情報保存
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save
    #order_details情報保存
    current_customer.cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item.id
      order_detail.order_id = order.id
      order_detail.price = cart_item.item.add_tax_price
      order_detail.amount = cart_item.amount
      order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  private

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :postage, :price)
  end
end
