class ChangeInputItemDefaultValueToString < ActiveRecord::Migration[5.2]
  def change
    change_column :input_items, :default_value, :string
  end
end
