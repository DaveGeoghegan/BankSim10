class InputItem < ActiveRecord::Base

  belongs_to :input_screen, :optional => true

  belongs_to :simulation, :optional => true

  class << self

    def build_input_items(simulation)

      the_config_file = Rails.root.join('config', 'BankSim_2021_Input_list.csv').to_s
      ap the_config_file
      csv = CSV.read(the_config_file, :headers => true , :encoding => "utf8")
      csv.each do |row|
        puts "Doing a row "
        ap row
        max = row['Max']
        ap max
        input_item = InputItem.new
        input_item.identifier = row['ID']
        input_item.default_value = row['Default Value']
        input_item.max_value = row['Max']
        input_item.min_value = row['Min']

        input_item.value_label = row['Value Label']
        input_item.label = row['Label']
        input_item.kind = row['Type']
        input_item.options = row['Options']
        input_item.infolink = row['info-link']
        input_item.number_of_decimal_places = row['Number of Decimal Places']
        input_item.simulation = simulation
        input_item.save!
      end
       puts " Input Items Built!"
    end
  end
end
