class TradesController < ApplicationController
  before_action :set_team
  def index
    @trades = Trade.all.reverse
  end

  def show
    @team = Team.find(params["team_id"])
    @review_trades = @team.trades.reverse
    @pending_trades = Trade.where(team1_id: params["team_id"])
  end

  def new
    @current_team = Team.find(current_user.team_id)
    @teams = Team.where.not("id = 33 OR id = ?", @current_team.id )
    @team_options = []
    @teams.each do |team|
      @team_options << [team.full_name, team.id]
    end
  end

  private

  def set_team
    if current_user
      cookies[:team_id] = current_user.team_id
    end
  end
end
