class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string :value
      t.integer :setup_group_id
      t.integer :tuning_id
      t.integer :setting_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
