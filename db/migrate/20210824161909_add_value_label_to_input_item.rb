class AddValueLabelToInputItem < ActiveRecord::Migration[5.2]
  def change
    add_column :input_items, :value_label, :string
  end
end
