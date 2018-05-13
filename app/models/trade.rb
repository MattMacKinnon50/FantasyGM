class Trade < ApplicationRecord
  validates :team1_id, numericality: { only_integer: true }
  validates :last_name, presence: :true

  belongs_to :team

  def name
    [first_name, last_name].join(' ')
  end
end
