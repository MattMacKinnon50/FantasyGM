class UpdateContracts < ActiveRecord::Migration[5.2]
  def up
    remove_column :contracts, :total, :string, null: false
    remove_column :contracts, :aav, :string, null: false
    remove_column :contracts, :guaranteed, :string, null: false
    add_column :contracts, :total, :integer, null: false
    add_column :contracts, :aav, :integer, null: false
    add_column :contracts, :guaranteed, :integer, null: false
  end
  def down
    change_column :contracts, :total, :string, null: false
    change_column :contracts, :aav, :string, null: false
    change_column :contracts, :guaranteed, :string, null: false
  end
end
