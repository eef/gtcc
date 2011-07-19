class AddCarNameToLeagueCars < ActiveRecord::Migration
  def self.up
    add_column :league_cars, :car_name, :string
  end

  def self.down
    remove_column :league_cars, :string
  end
end