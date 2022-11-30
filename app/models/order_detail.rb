class OrderDetail < ApplicationRecord
  belongs_to :home
  belongs_to :item
  belongs_to :order
end
