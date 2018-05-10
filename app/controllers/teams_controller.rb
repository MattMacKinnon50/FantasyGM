class TeamsController < ApplicationController
  before_action :set_user
  def index
    @teams = Team.where.not(abbr: "FA")
    @teams = @teams.order(:division, :conference, :city)
  end

  def show
      @team = Team.find(params[:id])
      playerList = @team.players.where.not(position: nil)
      @players = playerList.order(:last_name)
  end

  private

  def set_user
    if current_user
      if current_user.admin? || current_user.team_id.to_s == params[:id]
        cookies[:manager] = true
      else
        cookies[:manager] = false
      end
    else
      cookies[:manager] = false
    end
  end
end
