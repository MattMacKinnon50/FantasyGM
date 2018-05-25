class ChangePlayerPickToInt < ActiveRecord::Migration[5.2]
  def up
    change_column :players, :college_draft_pick, 'integer USING CAST(college_draft_pick AS integer)'
  end

  def down
    change_column :players, :college_draft_pick, :string
  end
end
