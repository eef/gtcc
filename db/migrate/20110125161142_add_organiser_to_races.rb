class AddOrganiserToRaces < ActiveRecord::Migration
  def self.up
    add_column :races, :organiser_id, :integer
  end

  def self.down
    remove_column :races, :organiser_id
  end
end