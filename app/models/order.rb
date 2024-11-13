class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products

  scope :filtered, ->(value) { value.present? ? where(id: value) : all }
  scope :with_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }
  def value_of_all_products
    order_products.sum(:value)
  end
end
