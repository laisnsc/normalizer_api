class User < ApplicationRecord
  has_many :orders

  validates :name, presence: true

  scope :with_orders, ->(order_id) { joins(:orders).where(orders: {id: order_id }) }
end
