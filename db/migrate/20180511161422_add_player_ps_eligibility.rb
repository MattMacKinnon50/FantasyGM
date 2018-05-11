class AddPlayerPsEligibility < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :ps_eligibility, :boolean, default: false
  end
end
