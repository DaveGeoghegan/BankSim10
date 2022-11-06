class AddiSAdminToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :is_admin, :boolean , default: false
  end
end
