class AddMinMaxToInputItem < ActiveRecord::Migration[5.2]
  def change
    add_column :input_items, :max_value, :float
    add_column :input_items, :min_value, :float
    add_column :input_items, :simulation_id, :integer
    add_column :input_items, :options, :text
  end
end
