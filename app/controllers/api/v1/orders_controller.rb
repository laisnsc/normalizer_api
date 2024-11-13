module Api::V1
  class OrdersController < ApplicationController
    def index
      orders = Order.all
      render json: orders
    end
  end
end