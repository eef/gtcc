class CreateUpgradeGroups < ActiveRecord::Migration
  def self.up
    create_table :upgrade_groups do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end

  def self.down
    drop_table :upgrade_groups
  end
end
