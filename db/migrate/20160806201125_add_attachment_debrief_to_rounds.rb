class AddAttachmentDebriefToRounds < ActiveRecord::Migration[5.2]
  def self.up
    change_table :rounds do |t|
      # t.attachment :debrief
    end
  end

  def self.down
    # remove_attachment :rounds, :debrief
  end
end
