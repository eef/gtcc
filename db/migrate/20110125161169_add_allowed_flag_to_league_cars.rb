class AddAllowedFlagToLeagueCars < ActiveRecord::Migration
  def self.up
    add_column :league_cars, :allowed, :boolean, :default => false
  end

  def self.down
    remove_column :league_cars, :allowed
  end
end