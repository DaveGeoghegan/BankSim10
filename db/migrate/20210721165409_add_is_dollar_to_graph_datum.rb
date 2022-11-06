class AddIsDollarToGraphDatum < ActiveRecord::Migration[5.2]
  def change
    add_column :graph_data, :is_dollar, :integer
  end
end
