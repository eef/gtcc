class AddExtraToRaces < ActiveRecord::Migration
  def self.up
    add_column :races, :race_type, :string
    add_column :races, :max_players, :integer, :default => 2
    add_column :races, :public, :boolean, :default => true
  end

  def self.down
    remove_column :races, :public
    remove_column :races, :max_players
    remove_column :races, :race_type
  end
end