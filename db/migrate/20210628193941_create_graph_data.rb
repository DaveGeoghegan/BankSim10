class CreateGraphData < ActiveRecord::Migration[5.2]
  def change
    create_table :graph_data do |t|
      t.string :graph_id
      t.string :x_labels
      t.string :graph_label
      t.string :data
      t.string :y_min
      t.string :y_max
      t.string :y_step
      t.string :datatype
      t.integer :team_round_id
      t.string :number_of_decimal_places

      t.timestamps
    end
  end
end
