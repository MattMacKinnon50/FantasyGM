class RemoveWikipediaFromTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :wikipedia_wordmark_url, :string
    remove_column :teams, :wikipedia_logo_url, :string
  end
end
