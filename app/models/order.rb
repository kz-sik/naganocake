class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer

  enum payment: { credit_card: 0, transfer: 1 }
  enum order_status: { before_payment: 0, payment_confirmation: 1, in_production: 2, delivery_preparation: 3, delivered: 4 }
end
