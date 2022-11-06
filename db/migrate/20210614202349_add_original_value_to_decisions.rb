class AddOriginalValueToDecisions < ActiveRecord::Migration[5.2]
  def change
    add_column :decisions, :original_value, :string
    add_column :decisions, :is_modified, :boolean
  end
end
