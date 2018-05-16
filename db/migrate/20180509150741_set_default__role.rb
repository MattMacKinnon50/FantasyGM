class SetDefaultRole < ActiveRecord::Migration[5.2]
  def change
    change_column :players, :role, :string, default: "b"
  end
end
