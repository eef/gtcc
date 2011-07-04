class AddCarClassIdToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :car_class_id, :integer
    add_column :standings, :car_class_id, :integer
  end

  def self.down
    remove_column :table_name, :car_class_id
    remove_column :results, :car_class_id
  end
end