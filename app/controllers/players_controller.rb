class PlayersController < ApplicationController
  def index
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
  end

  def add
    player = Player.find(params["player_id"])
    team = Team.find(current_user.team_id)
    player.team = team
    player.save
    flash[:notice] = "#{player.name} added to #{team.full_name} bench."
    redirect_back(fallback_location: "/teams/33")
  end

end
