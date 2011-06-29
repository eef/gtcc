class CreateLeaguePoints < ActiveRecord::Migration
  def self.up
    create_table :league_points do |t|
      t.integer :position
      t.integer :points
      t.integer :league_id
      t.integer :race_id

      t.timestamps
    end
  end

  def self.down
    drop_table :league_points
  end
end
