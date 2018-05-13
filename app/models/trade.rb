class Trade < ApplicationRecord
  validates :team_id, inclusion: { in: 1..32 }
  validates :team1_id, inclusion: { in: 1..32 }
  validates :team2_id, inclusion: { in: 1..32 }
  validates :team1_assets, presence: true
  validates :team2_assets, presence: true


  belongs_to :team

  def name
    [first_name, last_name].join(' ')
  end
end
