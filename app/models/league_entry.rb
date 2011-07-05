class LeagueEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  belongs_to :car_class
  belongs_to :league_car
end
