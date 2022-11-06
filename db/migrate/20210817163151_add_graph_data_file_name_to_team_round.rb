class AddGraphDataFileNameToTeamRound < ActiveRecord::Migration[5.2]
  def change
    add_column :team_rounds, :graph_data_file_name, :string
  end
end
