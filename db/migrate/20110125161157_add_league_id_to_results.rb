class AddLeagueIdToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :league_id, :integer
  end

  def self.down
    remove_column :results, :league_id
  end
end