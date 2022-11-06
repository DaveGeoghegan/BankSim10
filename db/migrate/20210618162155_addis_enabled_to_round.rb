class AddisEnabledToRound < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :is_enabled, :boolean
    add_column :rounds , :is_active , :boolean
    add_column :rounds , :is_closed , :boolean
  end
end
