class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :name
      t.text :description
      t.references :location
      t.references :track_type

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
