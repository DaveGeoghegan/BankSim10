class AddSimulationIdToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :simulation_id, :integer
  end
end
