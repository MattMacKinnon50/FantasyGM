class CreateTeam < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :abbr, null: :false
      t.string :city, null: :false
      t.string :name, null: :false
      t.string :conference
      t.string :division
      t.string :head_coach
      t.string :offensive_coordinator
      t.string :defensive_coordinator
      t.string :special_teams_coach
      t.string :primary_color
      t.string :secondary_color
      t.string :tertiary_color
      t.string :quaternary_color
      t.string :wikipedia_logo_url
      t.string :wikipedia_wordmark_url
      t.string :stadium_name
      t.string :stadium_city
      t.string :stadium_state
      t.string :stadium_country
      t.string :stadium_capacity
      t.string :stadium_playing_surface
      t.timestamps
    end
  end
end
