class Team < ApplicationRecord
  validates :abbr, presence: :true
  validates :city, presence: :true
  validates :name, presence: :true

  has_many :players
end
