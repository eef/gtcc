class CreateOwnedCars < ActiveRecord::Migration
  def self.up
    create_table :owned_cars do |t|
      t.string :nickname
      t.integer :car_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :owned_cars
  end
end
