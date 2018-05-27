class Contract < ApplicationRecord
belongs_to :team
belongs_to :player

validates :length, numericality: true
validates :start_year, numericality: true
validates :total, presence: true
validates :aav, presence: true
validates :guaranteed, presence: true


end
