class Race < ActiveRecord::Base
  # has_and_belongs_to_many :teams
  belongs_to :car
  belongs_to :track
  belongs_to :location
  belongs_to :organiser, :class_name => "User", :foreign_key => "organiser_id", :validate => true
  before_save :set_location
  has_and_belongs_to_many :users
  has_many :race_regulations
  accepts_nested_attributes_for :race_regulations, :allow_destroy => true
  
  validates_presence_of :name, :track, :start_time, :timezone
  validates_presence_of :laps
  
  def set_location
    self.location_id = self.track.location_id
  end
end
