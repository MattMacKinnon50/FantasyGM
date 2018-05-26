class ChangePlayerWeightToInt < ActiveRecord::Migration[5.2]
  def up
    change_column :players, :weight, 'integer USING CAST(weight AS integer)'
  end

  def down
    change_column :players, :weight, :string
  end
end
