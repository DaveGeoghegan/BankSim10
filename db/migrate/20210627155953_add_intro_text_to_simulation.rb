class AddIntroTextToSimulation < ActiveRecord::Migration[5.2]
  def change
    add_column :simulations, :intro_text, :text
  end
end
