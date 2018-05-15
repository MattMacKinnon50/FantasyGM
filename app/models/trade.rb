class Trade < ApplicationRecord

  validates :team_id, inclusion: { in: 1..32 }
  validates :team1_id, inclusion: { in: 1..32 }
  validates :team2_id, inclusion: { in: 1..32 }
  validates :team1_assets, presence: true
  validates :team2_assets, presence: true


  belongs_to :team

  def team1
    Team.find(team1_id)
  end

  def team2
    Team.find(team2_id)
  end

  def team1_players
    player_ids = JSON.parse(team1_assets)
    players = []
    player_ids.each do |id|
      players << Player.find(id)
    end
    players
  end

  def team2_players
    player_ids = JSON.parse(team2_assets)
    players = []
    player_ids.each do |id|
      players << Player.find(id)
    end
    players
  end

end
