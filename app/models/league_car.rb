class LeagueCar < ActiveRecord::Base
  belongs_to :league
  belongs_to :car
  belongs_to :car_class
end
