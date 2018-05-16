class SetDefaultRole < ActiveRecord::Migration[5.2]
  def change
    change_column :players, :role, :default => "b"
  end
end
