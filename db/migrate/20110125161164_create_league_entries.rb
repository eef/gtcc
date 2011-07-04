class CreateLeagueEntries < ActiveRecord::Migration
  def self.up
    create_table :league_entries do |t|
      t.integer :user_id
      t.integer :car_class_id
      t.integer :league_id

      t.timestamps
    end
  end

  def self.down
    drop_table :league_entries
  end
end
