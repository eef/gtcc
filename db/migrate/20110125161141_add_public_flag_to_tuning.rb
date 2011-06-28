class AddPublicFlagToTuning < ActiveRecord::Migration
  def self.up
    add_column :tunings, :public, :boolean, :default => false
  end

  def self.down
    remove_column :tunings, :public
  end
end