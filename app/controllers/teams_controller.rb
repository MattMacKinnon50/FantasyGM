class TeamsController < ApplicationController
  def index
    @teams = Team.where.not(abbr: "FA")
    @teams = @teams.order(:division, :conference, :city)
  end

  def show
      @team = Team.find(params[:id])
      playerList = @team.players.where.not(position: nil)
      @players = playerList.order(:last_name)
  end
end
