class Standing < ActiveRecord::Base
  belongs_to :league
  belongs_to :user
  belongs_to :car_class
end
