class CreateRelatedReports < ActiveRecord::Migration[5.2]
  def change
    create_table :related_reports do |t|
      t.string :name
      t.integer :input_screen_id

      t.timestamps
    end
  end
end
