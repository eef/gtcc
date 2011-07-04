class CarClass < ActiveRecord::Base
  belongs_to :league
  has_many :league_entries
end
