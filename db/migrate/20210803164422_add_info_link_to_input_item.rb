class AddInfoLinkToInputItem < ActiveRecord::Migration[5.2]
  def change
    add_column :input_items, :infolink, :text
  end
end
