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
  accepts_nested_attributes_for :league_cars, :allow_destroy => true
  accepts_nested_attributes_for :league_entries, :allow_destroy => true
  accepts_nested_attributes_for :car_classes, :allow_destroy => true
  accepts_nested_attributes_for :race_regulations, :allow_destroy => true
  accepts_nested_attributes_for :event_settings, :allow_destroy => true
  accepts_nested_attributes_for :league_points, :allow_destroy => true
  
  # class methods
  class << self
    
    def open_leagues
      where(:open => true)
    end
    
    def closed_leagues
      where(:open => false)
    end
    
  end
  
  # instance methods
  def register_driver(user, league_car)
    if league_car.amount > 0
      league_entry = LeagueEntry.new
      league_entry.user = user
      league_entry.league = self
      league_entry.league_car_id = league_car.id
      league_entry.car_class_id = league_car.car_class.id
      league_car.amount -= 1
      if league_entry.save and league_car.save
        true
      else
        false
      end
    else
      false
    end
  end
  
  def unregister_driver(user)
    rec = self.league_entries.where(:user_id => user).first
    league_car = rec.league_car
    league_car.amount += 1
    if rec.destroy and league_car.save
      true
    else
      false
    end
  end
  
  def is_registered?(current_user)
    test = self.league_entries.where(:user_id => current_user.id)
    ap test.inspect
    if test.length > 0
      true
    else
      false
    end
  end
  
end
