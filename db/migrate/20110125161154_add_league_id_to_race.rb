class AddLeagueIdToRace < ActiveRecord::Migration
  def self.up
    add_column :races, :league_id, :integer
  end

  def self.down
    remove_column :races, :league_id
  end
end