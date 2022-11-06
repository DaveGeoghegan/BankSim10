class CreateTeamRoundInputScreen < ActiveRecord::Migration[5.2]
  def change
    create_table :team_round_input_screens do |t|
      t.integer :team_round_id
      t.integer :input_screen_id
      t.boolean :was_visited
      t.boolean :data_entered
    end
  end
end
