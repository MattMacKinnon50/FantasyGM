class ChangeStaterToRole < ActiveRecord::Migration[5.2]
  def change
    rename_column :players, :starting, :role
  end
end
