class Item < ApplicationRecord
  has_many :order_details
  has_many :cart_items
  belongs_to :genre
  has_one_attached :image

  def add_tax_price
    (self.price * 1.10).round
  end

  def get_item_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
