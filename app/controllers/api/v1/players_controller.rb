class Api::V1::PlayersController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  def index
    render json: Player.where(team_id: params[:id])
  end

  def update
    players = params["players"]
    teams = Team.all
    abbr_array = []
    teams.each do |team|
      abbr_array << team.abbr
    end
    players.each do |id, value|
      binding.pry
      player = Player.find(id)
      if abbr_array.include?(value)
        team = Team.find_by(abbr: value)
        player.team = team
        player.save
      else
        player.role = value
        player.save
      end
    end
  end
end
