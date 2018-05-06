class Team < ApplicationRecord
  validates :abbr, presence: :true
  validates :city, presence: :true
  validates :name, presence: :true
  validates :conference
  validates :division
  validates :head_coach
  validates :offensive_coordinator
  validates :defensive_coordinator
  validates :special_teams_coach
  validates :primary_color
  validates :secondary_color
  validates :wikipedia_logo_url
  validates :wikipedia_wordmark_url
  validates :stadium_name
  validates :stadium_city
  validates :stadium_state
  validates :stadium_country
  validates :stadium_capacity
  validates :stadium_playing_surface
end
