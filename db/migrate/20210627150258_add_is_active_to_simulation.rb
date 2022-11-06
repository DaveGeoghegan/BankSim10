class AddIsActiveToSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :simulations, :is_active, :boolean
  end
end
