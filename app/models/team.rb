class Team < ApplicationRecord
  validates :abbr, presence: :true
  validates :city, presence: :true
  validates :name, presence: :true

  has_many :players
  has_many :trades

  def full_name
    [city, name].join(' ')
  end
end
