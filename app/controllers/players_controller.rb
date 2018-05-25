class PlayersController < ApplicationController
  def index
    if current_user
      @current_team = Team.find(current_user.team_id)
    else
      @current_team = Team.find(33)
    end
    if params[:name]
      @search_terms = params[:name]
      if @search_terms && @search_terms != ""
        @results = Player.search_by_full_name(@search_terms)
      end
    elsif params[:q]
      @q = Player.ransack(params[:q])
      @results = @q.result(distinct: true)
    end
    if @results.length > 66
      flash[:notice] = "Found #{@results.length} players. Search results limited to first 66 players found."
      @results = @results.first(66)
    end
  end

  def new
    if current_user
      @current_team = Team.find(current_user.team_id)
    else
      @current_team = Team.find(33)
    end
    @q = Player.ransack(params[:q])
    @teams = Team.all
    @positions = Player.positions
    @draft_teams = Player.draft_info[:teams]
    @draft_years = Player.draft_info[:years]
    @draft_rounds = Player.draft_info[:rounds]
    @height = Player.height_data
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
  end

  def add
    player = Player.find(params["player_id"])
    team = Team.find(current_user.team_id)
    player.team = team
    player.role = "b"
    player.save
    flash[:notice] = "#{player.name} added to #{team.full_name} bench."
    redirect_back(fallback_location: "/teams/33")
  end

  def drop
    player = Player.find(params["player_id"])
    team = Team.find(33)
    player.team = team
    player.role = "b"
    player.save
    flash[:notice] = "#{player.name} released to Free Agency."
    redirect_back(fallback_location: "/teams/#{current_user.team_id}")
  end

end
