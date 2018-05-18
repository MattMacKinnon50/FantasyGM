class AddWordmarkToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :wordmark, :string
  end
end
