class AdminController < ApplicationController

  before_action :ensure_user_is_admin




  def index
    puts "Home INdex"
    puts current_team.to_s
    puts "Was Current User"
    puts "Team Round"
    puts @team_round

    @team_round = current_team_round
    @round = current_team_round.round
  end

  def about

  end

  def manage_teams
    @simulation = Simulation.find(params[:simulation_id])
  end
end
