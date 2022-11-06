class AddInputScreenNumberToInputScreen < ActiveRecord::Migration[5.2]
  def change
    add_column :input_screens, :input_screen_number , :integer
  end
end
