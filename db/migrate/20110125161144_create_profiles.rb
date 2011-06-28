class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.string :psn_name
      t.string :reddit_name
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
