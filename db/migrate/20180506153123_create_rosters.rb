class CreateRosters < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.belongs_to :team, index: true
      t.string :nfl_team
      t.string :number
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :position
      t.string :height
      t.string :weight
      t.string :birth_date
      t.string :college
      t.integer :experience
      t.string :photo_url
      t.string :bye_week
      t.string :college_draft_team
      t.string :college_draft_year
      t.string :college_draft_round
      t.string :college_draft_pick
      t.boolean :undrafted_free_agent_status
      t.integer :fantasy_alarm_player_id
      t.string :sports_radar_player_id
      t.integer :rotoworld_player_id
      t.integer :rotowire_player_id
      t.integer :stats_player_id
      t.integer :sports_direct_player_id
      t.integer :xmlteam_player_id
      t.integer :fanduel_player_id
      t.integer :draftkings_player_id
      t.integer :yahoo_player_id
      t.integer :fantasydraft_player_id
      t.integer :fantasy_stats_2017
      t.integer :fantasy_stats_ppr_2017
    end
  end
end
