class AddLeague < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :display_name, limit: 12
      t.integer :league_year
      t.integer :salary_cap
      t.timestamps
    end
  end
end
