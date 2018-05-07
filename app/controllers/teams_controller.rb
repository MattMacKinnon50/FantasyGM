class TeamsController < ApplicationController
  def index
    @teams = Team.where.not(abbr: "FA")
    @teams = @teams.order(:division, :conference, :city)
  end
  def show
    @team = Team.find(params[:id])
    @players = @team.players.order(:last_name)
  end
end
