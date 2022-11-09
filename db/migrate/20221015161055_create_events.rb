class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :event_date
      t.string :address
      t.integer :event_capacity
      t.string :event_name
      t.integer :event_price
      t.timestamps
    end
  end
end
