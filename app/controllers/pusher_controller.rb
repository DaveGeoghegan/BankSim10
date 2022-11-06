class PusherController < ApplicationController
  skip_before_action :verify_authenticity_token

  def auth
    if current_team
      response = Pusher.authenticate(params[:channel_name], params[:socket_id])
      render json: response
    else
      render text: 'Forbidden', status: '403'
    end
  end
end