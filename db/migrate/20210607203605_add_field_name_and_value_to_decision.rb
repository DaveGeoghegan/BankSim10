class AddFieldNameAndValueToDecision < ActiveRecord::Migration[5.2]
  def change

    add_column :decisions, :field_name , :string
    add_column :decisions, :field_value , :string
  end
end
