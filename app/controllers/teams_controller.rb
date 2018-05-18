class TeamsController < ApplicationController
  before_action :set_user
  def index
    @teams = Team.where.not(abbr: "FA")
    @teams = @teams.order(:conference, :division, :city)
  end

  def show
    if params[:id] == "free_agents"
      @team = Team.find(33)
    else
      @team = Team.find(params[:id])
    end
    playerList = @team.players
    @players = playerList.order(:last_name)
  end

  def edit
    @team = Team.find(params[:id])
    if !current_user || current_user.team_id != @team.id
      flash[:notice] = "You can only edit your own team's details."
      redirect_back(fallback_location: "/teams/")
    end
  end

  def update
    redirect_back(fallback_location: "/teams/")
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
