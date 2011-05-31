class CreateSetupGroups < ActiveRecord::Migration
  def self.up
    create_table :setup_groups do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end

  def self.down
    drop_table :setup_groups
  end
end
