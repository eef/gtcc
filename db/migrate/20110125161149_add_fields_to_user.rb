class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :psn_name, :string
    add_column :users, :reddit_name, :string
    add_column :users, :age, :integer
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :psn_name
    remove_column :users, :reddit_name
    remove_column :users, :age
  end
end