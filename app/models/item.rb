class Item < ApplicationRecord
  belongs_to :genre
  has_one_attached :image

  enum is_active: { on_sale: '0', stopping_sales: '1' }
end
