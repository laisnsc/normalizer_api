class ChangeTypeForValue < ActiveRecord::Migration[8.0]
  def change
    change_table :order_products do |t|
      t.change :value, :float
    end
  end
end
