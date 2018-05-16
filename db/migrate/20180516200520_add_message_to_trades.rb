class AddMessageToTrades < ActiveRecord::Migration[5.2]
  def change
    add_column :trades, :message, :text
  end
end
