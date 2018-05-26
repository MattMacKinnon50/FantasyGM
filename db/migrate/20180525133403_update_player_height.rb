class UpdatePlayerHeight < ActiveRecord::Migration[5.2]
  def up
    remove_column :players, :height_inches, :integer
    change_column :players, :height_feet, :decimal, precision: 4, scale: 3
  end

  def down
    add_column :players, :height_inches, :integer
    change_column :players, :height_feet, :integer
  end
end
