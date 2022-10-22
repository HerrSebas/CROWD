class AddTicketsQuantityToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :tickets_quantity, :integer
  end
end
