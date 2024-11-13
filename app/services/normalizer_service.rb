class NormalizerService

  def initialize(file)
    raise ArgumentError, "File does not exist" if file.blank?
    @data = File.readlines(file).map(&:chomp)
  end

  def process_data
    normalized_data = normalize_data(@data)
    persist_data(normalized_data)
    generate_response(params)
  end

  private

  def normalize_data(data)
    user_data = {}
    user_orders_data = []
    data.each do |row|
      user_id = row[0...10].to_i
      name = row[10...55].strip
      order_id = row[55...65].to_i
      product_id = row[65...75].to_i
      product_name = "prod_#{product_id}"
      value = row[75...87].to_f
      date = row[87...95]

      user_data[user_id] = { user_id: user_id, name: name }
      user_orders_data << { user_id: user_id, order_id: order_id, date: date, product_id: product_id,
                            value: value, name: product_name }
    end
    {'users' => user_data.values, 'orders' => user_orders_data }
  end

  def persist_data(data)
    find_or_create_object(data['users'], 'user', :name)
    find_or_create_object(data['orders'], 'order', :user_id, :date)
    find_or_create_object(data['orders'],'product', :name)
    find_or_create_object(data['orders'], 'order_product',:order_id, :product_id, :value)
  end

  def find_or_create_object_test(objects, model, *params)
    model_class = Object.const_get("#{model.classify}")
    objects.each do |object|
      attributes = params.map { |param| [param, object[param]] }.to_h
      record = model_class.find_or_initialize_by(id: object["#{model}_id".to_sym])
      record.assign_attributes(attributes)
      record.save!
    end
  end

  def generate_response(params)
    User.with_orders(params).map do |user|
        {
          user_id: user.id,
          name: user.name,
          orders: get_order_data(user.orders)
        }
    end
  end

  def get_order_data(orders)
    orders.map do |order|
      {
        order_id: order.id,
        total: format("%.2f", order.value_of_all_products),
        date: order.date.strftime("%Y-%m-%d"),
        products: get_order_product_data(order.order_products)
      }
    end
  end

  def get_order_product_data(products)
    products.map { |prod| { product_id: prod.product_id, value: sprintf("%.2f", prod.value) } }
  end
end
