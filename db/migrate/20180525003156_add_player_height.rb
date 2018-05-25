class AddPlayerHeight < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :height_feet, :integer
    add_column :players, :height_inches, :integer
  end
end
