class AddOpenToLeague < ActiveRecord::Migration
  def self.up
    add_column :leagues, :open, :boolean, :default => true
  end

  def self.down
    remove_column :leagues, :open
  end
end