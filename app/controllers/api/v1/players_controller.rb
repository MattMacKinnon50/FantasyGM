class Api::V1::PlayersController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  def index
    render json: Player.where(team_id: params[:id])
  end
end
