class AddAttachmentReportToTeamRounds < ActiveRecord::Migration[5.2]
  def self.up
    change_table :team_rounds do |t|
      # t.attachment :report
    end
  end

  def self.down
    # remove_attachment :team_rounds, :report
  end
end
