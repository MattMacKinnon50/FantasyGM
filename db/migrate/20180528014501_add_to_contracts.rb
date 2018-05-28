class AddToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :expires, :integer
    add_column :players, :eligbile_for_signing, :boolean, default: false
  end
end
