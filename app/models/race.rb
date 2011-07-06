class Race < ActiveRecord::Base
  # has_and_belongs_to_many :teams
  belongs_to :car
  belongs_to :track
  belongs_to :location
  belongs_to :league
  belongs_to :organiser, :class_name => "User", :foreign_key => "organiser_id", :validate => true
  has_and_belongs_to_many :users
  has_many :race_regulations, :dependent => :destroy
  has_many :event_settings, :dependent => :destroy
  has_many :results
  accepts_nested_attributes_for :race_regulations, :allow_destroy => true
  accepts_nested_attributes_for :event_settings, :allow_destroy => true
  accepts_nested_attributes_for :results
  
  validates_presence_of :name, :track, :start_time, :timezone
  validates_presence_of :laps
  
  after_save :calculate_standings
  before_create :set_location
  
  class << self
    def open_races
      where(:public => true).where(:league_id => nil).where(:open => true)
    end
    
    def closed_races
      where(:public => true).where(:league_id => nil).where(:open => false)
    end
  end
  
  private
  
    def set_location
      if self.new_record?
        self.location_id = self.track.location_id
      end
    end
    
    def first_place
      self.results.order("results.position asc").first.user.username
    end
  
    def calculate_standings
      unless self.league.blank?
        results_changed = self.results.any? {|r| r.changed? }
        unless self.league.standings.length > 0
          self.league.league_entries.each do |entry|
            standing = Standing.new(:points => 0)
            standing.league = self.league
            standing.user = league_entry.user
            standing.save
          end
        end
        if results_changed
          league_points = {}
          self.league.league_points.each { |lp| league_points[lp.position] = lp.points }
          self.league.league_entries.each do |entry|
            standing = entry.user.standings.where(:league_id => self.league.id).first
            results = entry.user.results.where(:league_id => self.league.id)
            points = 0
            results.each do |result|
              points += league_points[result.position]
            end
            standing.points = points
            standing.save
          end
        end
      end
    end
end
