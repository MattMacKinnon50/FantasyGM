class Api::V1::TradesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    players = Player.where.not(team_id: 33)
    teams = Team.where.not(id: 33)
    render json: {players: players, teams: teams}
  end

end
