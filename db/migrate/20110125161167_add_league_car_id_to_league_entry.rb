class AddLeagueCarIdToLeagueEntry < ActiveRecord::Migration
  def self.up
    add_column :league_entries, :league_car_id, :integer
  end

  def self.down
    remove_column :league_entries, :league_car_id
  end
end