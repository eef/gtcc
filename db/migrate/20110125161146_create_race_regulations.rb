class CreateRaceRegulations < ActiveRecord::Migration
  def self.up
    create_table :race_regulations do |t|
      t.boolean :skid_recovery
      t.boolean :active_steering
      t.boolean :asm
      t.boolean :driving_line
      t.boolean :tcs
      t.string :car_restriction
      t.integer :performance_points
      t.integer :power
      t.integer :weight
      t.string :tyre_restrictions
      t.integer :race_id
      t.integer :season_id
      t.timestamps
    end
  end

  def self.down
    drop_table :race_regulations
  end
end
