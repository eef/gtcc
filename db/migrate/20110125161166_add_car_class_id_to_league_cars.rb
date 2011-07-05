class AddCarClassIdToLeagueCars < ActiveRecord::Migration
  def self.up
    add_column :league_cars, :car_class_id, :integer
  end

  def self.down
    remove_column :league_cars, :car_class_id
  end
end