class AddUsedAmountToLeagueCar < ActiveRecord::Migration
  def self.up
    add_column :league_cars, :used_amount, :integer, :default => 0
  end

  def self.down
    remove_column :league_cars, :used_amount
  end
end