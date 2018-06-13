class CreateDeadMoney < ActiveRecord::Migration[5.2]
  def change
    create_table :dead_moneys do |t|
      t.belongs_to :team
      t.belongs_to :player
      t.string  :name
      t.integer :year
      t.integer :amount
      t.timestamps
    end
  end
end
