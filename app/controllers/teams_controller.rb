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
    league = League.first
    @cap = league.salary_cap
    @under_contract = @team.contract_total
    @dead_money = @team.dead_total
    @cap_space = @team.cap_space
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
    @team = Team.find(params[:id])
    @team.city = team_params[:city]
    @team.name = team_params[:name]
    if team_params[:logo]
      @team.logo = team_params[:logo]
    end
    if team_params[:wordmark]
      @team.wordmark = team_params[:wordmark]
    end
    @team.primary_color = team_params[:primary_color]
    @team.secondary_color = team_params[:secondary_color]
    @team.head_coach  = team_params[:head_coach]
    @team.offensive_coordinator = team_params[:offensive_coordinator]
    @team.defensive_coordinator = team_params[:defensive_coordinator]
    @team.special_teams_coach = team_params[:special_teams_coach]
    @team.stadium_name = team_params[:stadium_name]
    @team.stadium_city = team_params[:stadium_city]
    @team.stadium_state = team_params[:stadium_state]
    @team.stadium_playing_surface = team_params[:stadium_playing_surface]
    if @team.save
        redirect_to @team
    else
        flash.now[:message] = @team.errors.full_messages
        render :edit
    end
  end

  private
    def team_params
      params.require(:team).permit(:city, :name, :logo, :wordmark, :primary_color, :secondary_color, :head_coach, :offensive_coordinator, :defensive_coordinator, :special_teams_coach, :stadium_name, :stadium_city, :stadium_state, :stadium_capacity, :stadium_playing_surface)
    end

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
