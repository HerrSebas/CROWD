class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :total_price
      t.integer :order_status
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
