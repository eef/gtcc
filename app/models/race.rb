class Race < ActiveRecord::Base
  # has_and_belongs_to_many :teams
  belongs_to :car
  belongs_to :track
  belongs_to :location
  before_save :set_location
  
  def set_location
    self.location_id = self.track.location_id
  end
end
