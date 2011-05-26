class CreateUpgrades < ActiveRecord::Migration
  def self.up
    create_table :upgrades do |t|
      t.string :name
      t.integer :upgrade_group_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :upgrades
  end
end
