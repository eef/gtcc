class CreateTuningsUpgradesJoin < ActiveRecord::Migration
  def self.up
    create_table :tunings_upgrades, :id => false do |t|
      t.references :tuning
      t.references :upgrade
      t.timestamps
    end
  end

  def self.down
    drop_table :tunings_upgrades
  end
end