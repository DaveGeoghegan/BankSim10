class AddDecimalPlacesToInputItem < ActiveRecord::Migration[5.2]
  def change
    add_column :input_items, :number_of_decimal_places, :integer
  end
end
