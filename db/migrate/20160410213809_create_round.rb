class CreateRound < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.string :name
      t.integer :round_number
      t.timestamps null: false
    end
  end
end
