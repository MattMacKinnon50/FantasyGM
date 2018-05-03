class CreateTeam < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :abbr, null: :false
      t.string :city, null: :false
      t.string :name, null: :false
      t.string :conference, null: :false
      t.string :division, null: :false
      t.string :head_coach, null: :false
      t.string :offensive_coordinator, null: :false
      t.string :defensive_coordinator, null: :false
      t.string :special_teams_coach, null: :false
      t.string :primary_color, null: :false
      t.string :secondary_color, null: :false
      t.string :tertiary_color, null: :false
      t.string :quaternary_color, null: :false
      t.string :wikipedia_logo_url, null: :false
      t.string :wikipedia_wordmark_url, null: :false
      t.string :stadium_name, null: :false
      t.string :stadium_city, null: :false
      t.string :stadium_state, null: :false
      t.string :stadium_country, null: :false
      t.string :stadium_capacity, null: :false
      t.string :stadium_playing_surface, null: :false
      t.timestamps
    end
  end
end
