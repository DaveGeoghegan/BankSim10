class AddIsSubmittedToTeamRound < ActiveRecord::Migration[5.2]
  def change
    add_column :team_rounds, :is_submitted, :boolean , default: false
  end
end
