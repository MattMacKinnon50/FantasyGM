class Team < ApplicationRecord
  validates :abbr, presence: :true
  validates :city, presence: :true
  validates :name, presence: :true

  has_many :players

  def full_name
    [city, name].join(' ')
  end
end
