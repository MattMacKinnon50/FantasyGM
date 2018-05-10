class AddTeamToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.integer :team_id
    end
  end
end
