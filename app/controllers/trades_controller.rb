class TradesController < ApplicationController
  before_action :set_team
  def index
    if current_user
      @current_team = Team.find(current_user.team_id)
    else
      @current_team = Team.find(33)
    end
    @trades = Trade.all.reverse
  end

  def show
    @team = Team.find(params["team_id"])
    @review_trades = @team.trades.reverse
    @pending_trades = Trade.where(team1_id: params["team_id"])
  end

  def new
    @current_team = Team.find(current_user.team_id)
  end

  def update
    trade = Trade.find(params["id"])
    team1 = trade.team1
    team2 = trade.team2
    trade.team1_players.each do |player|
      if !team1.players.include?(player)
        trade.destroy
        flash[:notice] = "#{player.name} is no longer a member of #{team1.full_name} and is unavailable to trade.  This trade has been canceled."
        redirect_back(fallback_location: "/trades")
      end
    end
    trade.team2_players.each do |player|
      if !team2.players.include?(player)
        trade.destroy
        flash[:notice] = "#{player.name} is no longer a member of #{team2.full_name} and is unavailable to trade.  This trade has been canceled."
        redirect_back(fallback_location: "/trades")
      end
    end
    trade.team1_players.each do |player|
      player.team = team2
      player.role = "b"
      player.save
    end
    trade.team2_players.each do |player|
      player.team = team1
      player.role = "b"
      player.save
    end
    trade.destroy
    flash[:notice] = "Trade processed."
    redirect_back(fallback_location: "/trades")
  end

  def destroy
    trade = Trade.find(params[:id])
    trade.destroy
    redirect_back(fallback_location: "/trades")
  end

  private

  def set_team
    if current_user
      cookies[:team_id] = current_user.team_id
    end
  end
end
