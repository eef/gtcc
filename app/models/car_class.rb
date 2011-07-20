class CarClass < ActiveRecord::Base
  belongs_to :league
  has_many :league_entries
  has_many :users, :through => :league_entries
  has_many :results
  has_many :standings
  has_many :league_cars
end
