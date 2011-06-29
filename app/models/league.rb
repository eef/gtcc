class League < ActiveRecord::Base
  has_many :races, :dependent => :destroy
  belongs_to :organiser, :class_name => "User", :foreign_key => "organiser_id", :validate => true
  has_many :league_points, :dependent => :destroy
  has_many :race_regulations
  has_many :event_settings
  accepts_nested_attributes_for :race_regulations, :allow_destroy => true
  accepts_nested_attributes_for :event_settings, :allow_destroy => true
  accepts_nested_attributes_for :league_points, :allow_destroy => true
end
