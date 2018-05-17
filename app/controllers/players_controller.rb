class PlayersController < ApplicationController
  def index
    @search_terms = params[:name]
    if @search_terms && @search_terms != "" 
      @results = Player.search_by_full_name(@search_terms)
    end
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
