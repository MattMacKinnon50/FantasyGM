class PlayersController < ApplicationController
  def index
  end

  def show
    @player = Player.find(params[:id])
  end

  def add
    player = Player.find(params["player_id"])
    team = Team.find(current_user.team_id)
    player.team = team
    player.save
    flash[:notice] = "#{player.name} added to #{team.full_name} bench."
    redirect_to "/teams/33"
  end

end
