class AddOpenToRaces < ActiveRecord::Migration
  def self.up
    add_column :races, :open, :boolean, :default => true
  end

  def self.down
    remove_column :races, :open
  end
end