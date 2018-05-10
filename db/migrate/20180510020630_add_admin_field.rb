class AddAdminField < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.boolean :admin, default: :false
    end
  end
end
