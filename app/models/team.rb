class Team < ApplicationRecord
  default_scope { order(:city, :name) }
  validates :abbr, presence: :true
  validates :city, presence: :true
  validates :name, presence: :true

  has_many :players
  has_many :trades
  has_many :contracts
  has_many :dead_moneys

  mount_uploader :logo, LogoUploader
  mount_uploader :wordmark, WordmarkUploader

  def full_name
    [city, name].join(' ')
  end

  def self.surfaces
    teams = Team.all
    surfaces = []
    teams.each do |team|
      if !surfaces.include?(team.stadium_playing_surface)
        surfaces << team.stadium_playing_surface
      end
    end
    surfaces
  end

  def contract_total
    contracts = self.contracts
    contract_total = 0
    contracts.each do |contract|
      cap_hit = contract.details_by_year[contract.current_year_index][:cap]
      contract_total += cap_hit
    end
    contract_total
  end

  def dead_total
    dead_moneys = self.dead_moneys
    dead_total = 0
    dead_moneys.each do |dead_money|
      dead_total += dead_money.amount
    end
    dead_total
  end

  def cap_space
    league_cap = League.first.salary_cap
    league_cap - self.contract_total - self.dead_total
  end
end
