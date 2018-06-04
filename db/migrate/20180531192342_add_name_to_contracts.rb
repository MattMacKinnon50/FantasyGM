class AddNameToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :player_name, :string
  end
end
