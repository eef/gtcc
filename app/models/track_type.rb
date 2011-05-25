class TrackType < ActiveRecord::Base
  has_many :tracks
  has_many :locations 
end
