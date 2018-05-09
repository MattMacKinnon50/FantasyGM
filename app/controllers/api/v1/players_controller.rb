class Api::V1::PlayersController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  def index
    render json: Player.where(team_id: params[:id])
  end

  def update
    players = params["players"]
    players.each do |id, role|
      player = Player.find(id)
      player.role = role 
      player.save
    end
  end
end
