class CreateCarClasses < ActiveRecord::Migration
  def self.up
    create_table :car_classes do |t|
      t.integer :league_id
      t.string :name
      t.integer :max_players

      t.timestamps
    end
  end

  def self.down
    drop_table :car_classes
  end
end
