class HomeController < ApplicationController


  def index
    puts "Home INdex"
    puts current_team.to_s
    puts "Was Current User"
    puts "Team Round"
    puts @team_round
    @simulation = current_team.simulation
    @team_round = current_team_round
    @round = current_team_round.round
  end

  def welcome
    @my_html = "<b>Bold</b>"
    @simulation = current_team.simulation
  end

  def about

  end
end
