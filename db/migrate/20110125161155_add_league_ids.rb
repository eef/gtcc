class AddLeagueIds < ActiveRecord::Migration
  def self.up
    add_column :race_regulations, :league_id, :integer
    add_column :event_settings, :league_id, :integer
  end

  def self.down
    remove_column :event_settings, :league_id
    remove_column :race_regulations, :league_id
  end
end