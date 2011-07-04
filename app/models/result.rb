class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :race
  belongs_to :car_class
end
