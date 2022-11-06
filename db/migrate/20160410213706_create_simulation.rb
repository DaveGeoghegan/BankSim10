class CreateSimulation < ActiveRecord::Migration[5.2]
  def change
    create_table :simulations do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
