class AddDefaultToInputItem < ActiveRecord::Migration[5.2]
  def change
    add_column :input_items,  :default_value , :float
  end
end
