class CreateTunings < ActiveRecord::Migration
  def self.up
    create_table :tunings do |t|
      t.string :name
      t.integer :car_id
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :tunings
  end
end
