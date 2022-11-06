class RelatedReport < ActiveRecord::Base

  belongs_to :input_screen

  class << self
    def initialize_related_reports
      the_config_file = Rails.root.join('config', 'related_reports.csv').to_s
      ap the_config_file
      csv = CSV.read(the_config_file, :headers => true, :encoding => "utf8")
      csv.each do |row|
        puts "Doing a row "

        the_input_screen = InputScreen.where(:input_screen_number => row['ScreenNumber']).first
        if the_input_screen.nil?
          raise "Error: Can't find input screen for " + row
        else
          ap row
          related_report = RelatedReport.new
          related_report.name = row['Related Reports'] + " (Report " + row['Report #'] + ")"
          related_report.input_screen = the_input_screen
          related_report.save!
        end
        puts " Related Reports Built"
      end
    end
  end
end
