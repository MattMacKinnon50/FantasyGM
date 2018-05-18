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
    @surfaces = Team.surfaces
    @states = ["AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"]
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
