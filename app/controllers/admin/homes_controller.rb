class Admin::HomesController < ApplicationController
  def top
    @order_details = Order_detail.all
  end
end
