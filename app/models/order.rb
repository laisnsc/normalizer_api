class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products

  def value_of_all_products
    order_products.sum(:value)
  end
end
