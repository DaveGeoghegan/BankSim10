class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #
  #
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:simulation_id])
  end

  protect_from_forgery with: :exception

  helper_method :current_team

  helper_method :is_admin

  helper_method :current_simulation

  helper_method :current_team_round
  helper_method :previous_team_round
  helper_method :next_team_round

  before_action :authenticate_team!


  # def authenticate_team!
  #   puts "In Authenticator"
  #   ap current_team
  #
  #   if current_team.nil? then
  #     if request.fullpath != "/sessions/new" && request.fullpath != "/sessions" && request.fullpath != "/sessions/destroy"  then
  #       redirect_to "/sessions/new"
  #     end
  #   end
  # end
  #
  # def current_team
  #   @current_team ||= Team.find(session[:team_id]) if session[:team_id]
  # end
  #
  # def is_admin
  #   @current_team ||= Team.find(session[:team_id]) if session[:team_id]
  #   if @current_team.nil?
  #     return nil
  #   end
  #   if @current_team.name == "admin"
  #     return true
  #   end
  #   return false
  # end
  #
  def after_sign_in_path_for(resource)
    if current_team.is_admin
      return "/admin"
    end
    return "/home/welcome"
  end

  def ensure_user_is_admin
    if current_team.name == "admin" then
      return true
    else
      redirect_to "/"
    end
  end

  def current_simulation
    @current_simulation = Simulation.get_current_simulation
  end

  def current_team_round
    current_round = current_team.rounds.where(:is_active => true).first
    current_team_round = TeamRound.where(:round => current_round).where(:team => current_team).first
    return current_team_round
  end


  def previous_team_round
    if current_team.nil?
      return nil
    end
    current_team.team_rounds.each_with_index do |val, idx|
      if current_team_round == val then
        if idx == 0 then
          return nil
        else
          return current_team.team_rounds[idx - 1]
        end
      end
    end
  end

  def next_team_round
    if current_team.nil?
      return nil
    end
    current_team.team_rounds.each_with_index do |val, idx|
      if current_team_round == val then
        if idx == current_team.team_rounds.length - 1 then
          return nil
        else
          return current_team.team_rounds[idx + 1]
        end
      end
    end
  end

end
