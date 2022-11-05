class ChangeColumnNameForEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :event_price_cents
    add_column :events, :event_price, :integer
  end
end
