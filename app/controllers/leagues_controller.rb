class LeaguesController < ApplicationController

  def index
    @league = League.first
  end

  def show
    @league = League.first
  end
end
