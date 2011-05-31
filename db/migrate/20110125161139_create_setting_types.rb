class CreateSettingTypes < ActiveRecord::Migration
  def self.up
    create_table :setting_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :setting_types
  end
end
