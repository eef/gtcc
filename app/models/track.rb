class Track < ActiveRecord::Base
  belongs_to :location
  belongs_to :track_type
  belongs_to :race
end
