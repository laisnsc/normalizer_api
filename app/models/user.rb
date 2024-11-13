class User < ApplicationRecord
  has_many :orders

  validates :name, presence: true

  scope :with_orders, ->(order_id) { joins(:orders).where(orders: {id: order_id }).distinct }
  scope :with_orders_by_date, ->(from, to) do
    from.present? && to.present? ? joins(:orders).where(orders: {date: from..to }).distinct : all
  end
end

