class Player < ApplicationRecord
  default_scope { order(:last_name, :first_name) }

  validates :first_name, presence: :true
  validates :last_name, presence: :true

  belongs_to :team

  def name
    [first_name, last_name].join(' ')
  end
end
