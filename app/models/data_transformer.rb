class DataTransformer

  class << self
    def transform(table_name)
      puts "Doing it!"
      the_config_file = Rails.root.join('config', 'trmy.csv').to_s
      field_definitions = []
      mapper_entries = []
      data_entries = []
      field_names = []
      ap the_config_file
      csv = CSV.read(the_config_file, :headers => true, :encoding => "utf8")
      column = 'A'
      csv.each do |row|
        # puts "Doing a row "
        if row['File'] == table_name then
          puts "Processing a row " + row['name']
          #  public int Service_Acct_Nbr { get; set;}
          entry = "public "
          if row['Type'] == "A" then
            entry += " string "
            the_data_string = "X" * row['Length'].to_i
            puts "Data String is"
            puts the_data_string
            data_entries << the_data_string
          else
            if row['decimals'] == '0'
              entry += " Int64 "
              the_data_string = "10000000000"
              data_entries << the_data_string
            else
              entry += " float "
              the_data_string = "100000000.00000"
              data_entries << the_data_string
            end
          end
          entry += row['name']
          entry += " {get; set;}"
          field_definitions << entry
          # OK Let's do the mapper Map(p=>p.Service_Acct_Nbr).ToColumn("B1LWNB");
          mapper_entry = 'Map(p=>p.' + row['name'] + ').ToColumn("' + row['ExternalFieldName'] + '");'
          puts mapper_entry
          mapper_entries << mapper_entry
          ap entry
          # OK So now I need the DataBase Names
          field_names  << row['ExternalFieldName']

          ap row
        end
      end
      filename = Rails.root.join('config', table_name + '_mappings.text').to_s
      filename_csv = Rails.root.join('config', table_name + '_mappings.csv').to_s
      fieldnames_csv = Rails.root.join('config', table_name + '_field_names.csv').to_s
      File.write(filename, mapper_entries.join("\n"), mode: "w")
      File.write(filename, "\n\n", mode: "a")
      File.write(filename, field_definitions.join("\n"), mode: "a")
      File.write(filename, "\n\n", mode: "a")

      File.write(filename_csv, data_entries.join(","), mode: "a")

      File.write(fieldnames_csv, field_names.join(","), mode: "a")

      puts " Data Transformed"
    end
  end
end