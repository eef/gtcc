class AddCarsLeaguesJoin < ActiveRecord::Migration
  def self.up
    create_table :cars_leagues, :id => false do |t|
      t.references :car
      t.references :league
      t.timestamps
    end
  end

  def self.down
    drop_table :cars_leagues
  end
end
