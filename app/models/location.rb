class Location < ActiveRecord::Base
  belongs_to :track_type
  belongs_to :race
  has_many :tracks
end
