class AddFieldsToRace < ActiveRecord::Migration
  def self.up
    add_column :races, :start_time, :datetime
    add_column :races, :laps, :integer
    add_column :races, :timezone, :string, :default => "UTC"
    add_column :races, :psn_race_id, :string
  end

  def self.down
    remove_column :races, :psn_race_id
    remove_column :races, :timezone
    remove_column :races, :laps
    remove_column :races, :start_time
  end
end