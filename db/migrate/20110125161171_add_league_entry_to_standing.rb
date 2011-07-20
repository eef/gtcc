class AddLeagueEntryToStanding < ActiveRecord::Migration
  def self.up
    add_column :standings, :league_entry_id, :integer
  end

  def self.down
    remove_column :standings, :league_entry_id
  end
end