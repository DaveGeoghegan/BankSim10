class SessionsController < ApplicationController
  def new
    render "new" , :layout => 'login'
  end

  def create
    puts "Creating a Session"
    team  = Team.authenticate(params[:name],params[:password])
    if team
      session[:team_id] = team.id
      if team.name == "admin"
        redirect_to "/admin"
      else
        redirect_to root_url
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new" , :layout => 'login'
    end
  end

  def destroy
    session[:team_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
