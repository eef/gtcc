class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    add_column :users, :roles, :string, :default => "--- []"
  end

  def self.down
    remove_column :users, :roles
    remove_column :users, :username
  end
end