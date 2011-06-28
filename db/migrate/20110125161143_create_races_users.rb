class CreateRacesUsers < ActiveRecord::Migration
  def self.up
    create_table :races_users, :id => false do |t|
      t.references :race
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :races_users
  end
end
