class Player < ApplicationRecord
  validates :first_name, presence: :true
  validates :last_name, presence: :true

  belongs_to :team

end
