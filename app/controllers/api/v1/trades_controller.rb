class Api::V1::TradesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    players = Player.where.not(team_id: 33)
    teams = Team.where.not(id: 33)
    render json: {players: players, teams: teams}
  end

  def create
    trade = Trade.new
    trade.team_id = params["team_id"]
    trade.team1_id = params["team1Id"]
    trade.team2_id = params["team2Id"]
    trade.team1_assets = params["team1Assets"]
    trade.team2_assets = params["team2Assets"]
    trade.message = params["message"]
    trade.save
  end

end
