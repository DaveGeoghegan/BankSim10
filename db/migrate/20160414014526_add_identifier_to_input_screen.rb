class AddIdentifierToInputScreen < ActiveRecord::Migration[5.2]
  def change
    add_column :input_screens,  :identifier , :string
  end
end
