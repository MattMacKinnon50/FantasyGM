class AddLogoToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :logo, :string
  end
end
