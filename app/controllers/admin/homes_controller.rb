class Admin::HomesController < ApplicationController
  def top
    @order_details = Order_detail.all
  end

  private
  def home_params
    params.require(:home).permit(:order_details_id)
  end
end
