class CreateEventSettings < ActiveRecord::Migration
  def self.up
    create_table :event_settings do |t|
      t.string :mechanical
      t.string :game_mode
      t.string :penalty
      t.string :tyre_fuel_depletion
      t.string :grip_reduction
      t.string :grid_order
      t.string :start_type
      t.string :boost
      t.integer :shuffle_ratio
      t.integer :race_id
      t.timestamps
    end
  end

  def self.down
    drop_table :event_settings
  end
end
