class TeamsController < ApplicationController
  def index
    @teams = Team.where.not(abbr: "FA")
    @teams = @teams.order(:conference, :division, :city)
  end
  def show
    @team = Team.find(params[:id])
    @players = @team.players
  end
end
