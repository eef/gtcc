class CreateStandings < ActiveRecord::Migration
  def self.up
    create_table :standings do |t|
      t.integer :user_id
      t.integer :league_id
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :standings
  end
end
