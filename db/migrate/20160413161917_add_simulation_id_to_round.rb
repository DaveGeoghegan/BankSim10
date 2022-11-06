class AddSimulationIdToRound < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds,  :simulation_id , :integer
  end
end
