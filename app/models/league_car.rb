class LeagueCar < ActiveRecord::Base
  belongs_to :league
  belongs_to :car
  belongs_to :car_class
  has_many :users
  has_many :league_entries
  
end
