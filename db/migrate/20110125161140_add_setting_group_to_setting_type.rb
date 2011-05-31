class AddSettingGroupToSettingType < ActiveRecord::Migration
  def self.up
    add_column :setting_types, :setup_group_id, :integer
  end

  def self.down
    remove_column :setting_types, :setup_group_id
  end
end