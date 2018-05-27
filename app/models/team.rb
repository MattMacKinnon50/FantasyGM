class Team < ApplicationRecord
  validates :abbr, presence: :true
  validates :city, presence: :true
  validates :name, presence: :true

  has_many :players
  has_many :trades
  has_many :contracts

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

end
