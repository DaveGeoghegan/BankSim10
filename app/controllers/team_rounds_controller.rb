class TeamRoundsController < ApplicationController

  def reports
    puts "We Are Here"
  end

  def add_report
    my_params = params.permit(:round_report, :team_round_id)
    team_round = TeamRound.find(my_params[:team_round_id])
    @team = team_round.team
    puts "Team Round is "
    ap team_round
    team_round.round_report.attach(my_params[:round_report])
  end

  def add_graph_data
    my_params = params.permit(:team_round_id, :graph_data)
    team_round = TeamRound.find(my_params[:team_round_id])
    puts "Uploading File" + params[:graph_data].original_filename
    team_round.graph_data_file_name= params[:graph_data].original_filename
    team_round.save!
    @team = team_round.team
    CSV.foreach(params[:graph_data].path, headers: true , encoding: "utf-8") do |row|
      puts "I have a row"
      ap row
      graph_datum = GraphDatum.new
      graph_datum.team_round = team_round
      puts "the Graph id is " + row['graph_id']
      graph_datum.graph_id = row[0].squish()
      puts "New Value is " + graph_datum.graph_id
      graph_datum.x_labels= row['x_labels'].squish()
      graph_datum.graph_label= row['graph_label']
      graph_datum.data= [row['data_simstart'].squish(),row['data_round_1'].squish(),row['data_round_2'].squish(),row['data_round_3'].squish()].join(",")
      graph_datum.y_min= row['y_min'].squish()
      graph_datum.y_max= row['y_max'].squish()
      graph_datum.number_of_decimal_places = row['number_of_decimal_places'].squish()
      graph_datum.is_percent = row['is_percent'].to_i
      graph_datum.is_dollar = row['is_dollar'].to_i
      graph_datum.save!
      ap graph_datum
    end

  end

  def submit_decisions
    my_params = params.permit(:team_round_id)
    team_round = TeamRound.find(my_params[:team_round_id])
    if team_round.team != current_team then
      puts "Error"
      raise "error"
    else
      team_round.is_finished = true
      team_round.is_submitted = true
      team_round.finish_date = DateTime.now
      team_round.save!
    end

  end
end