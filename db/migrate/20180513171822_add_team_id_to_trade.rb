class AddTeamIdToTrade < ActiveRecord::Migration[5.2]
  def change
    add_column :trades, :team_id, :integer
    add_foreign_key :trades, :teams
  end
end
