class CreateLeagueCars < ActiveRecord::Migration
  def self.up
    create_table :league_cars do |t|
      t.integer :league_id
      t.integer :car_id
      t.integer :amount
      t.string :restrictions

      t.timestamps
    end
  end

  def self.down
    drop_table :league_cars
  end
end
