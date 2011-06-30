class AddLeaguesUsersTable < ActiveRecord::Migration
  def self.up
    create_table :leagues_users, :id => false do |t|
      t.references :league
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :races_users
  end
end
