class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.text :description
      t.references :track_type

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
