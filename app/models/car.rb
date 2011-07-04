class Car < ActiveRecord::Base
  belongs_to :manufacturer
  has_many :owned_cars
  has_many :league_cars
end
