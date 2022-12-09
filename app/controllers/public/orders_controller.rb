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

  end
end
