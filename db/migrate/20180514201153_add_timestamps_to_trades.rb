class AddTimestampsToTrades < ActiveRecord::Migration[5.2]
  def change
    change_table :trades do |t|
      t.timestamps
    end
  end
end
