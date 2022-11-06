class AddRoundsToSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :simulations,  :number_of_rounds , :integer
  end
end
