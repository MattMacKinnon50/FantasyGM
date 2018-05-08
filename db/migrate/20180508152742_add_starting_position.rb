class AddStartingPosition < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :starting, :string
  end
end
