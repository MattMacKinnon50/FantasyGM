class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.integer :team1_id, null: false
      t.integer :team2_id, null: false
      t.string :team1_assets, null: false
      t.string :team2_assets, null: false
    end
  end
end
