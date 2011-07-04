class League < ActiveRecord::Base
  has_many :races, :dependent => :destroy
  belongs_to :organiser, :class_name => "User", :foreign_key => "organiser_id", :validate => true
  has_many :league_points, :dependent => :destroy
  has_many :race_regulations, :dependent => :destroy
  has_many :event_settings, :dependent => :destroy
  has_many :results
  has_many :standings
  has_many :league_entries
  has_many :car_classes, :dependent => :destroy
  has_many :league_cars, :dependent => :destroy
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :league_cars, :allow_destroy => true
  accepts_nested_attributes_for :car_classes, :allow_destroy => true
  accepts_nested_attributes_for :race_regulations, :allow_destroy => true
  accepts_nested_attributes_for :event_settings, :allow_destroy => true
  accepts_nested_attributes_for :league_points, :allow_destroy => true
  
  class << self
    
    def open_leagues
      where(:open => true)
    end
    
    def closed_leagues
      where(:open => false)
    end
    
  end
end
