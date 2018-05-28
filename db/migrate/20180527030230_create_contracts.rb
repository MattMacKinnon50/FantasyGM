class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.belongs_to :player
      t.belongs_to :team
      t.integer :length, null: false
      t.integer :start_year, null: false
      t.integer :offered_to
      t.boolean :highest_bid
      t.string :total, null: false
      t.string :aav, null: false
      t.string :guaranteed, null: false
      t.timestamps
    end
  end
end
