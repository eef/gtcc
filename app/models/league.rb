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
  accepts_nested_attributes_for :league_cars, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :league_entries, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :car_classes, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :race_regulations, :allow_destroy => true
  accepts_nested_attributes_for :event_settings, :allow_destroy => true
  accepts_nested_attributes_for :league_points, :allow_destroy => true, :reject_if => :all_blank
  
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
    league_entry = LeagueEntry.new
    league_entry.user = user
    league_entry.league = self
    case league_car
    when Hash
      car_name = league_car
      league_car = LeagueCar.new
      league_car.car_name = car_name[:car_name]
      league_car.car_class_id = car_name[:car_class_id]
      league_entry.car_class_id = car_name[:car_class_id]
    when String
      car_name = league_car
      league_car = LeagueCar.new
      league_car.car_name = car_name
      league_entry.car_class = nil
    when LeagueCar
      league_entry.car_class = league_car.car_class unless league_car.car_class.blank?
      league_car.used_amount += 1
    end
    league_car.league = self
    league_entry.league_car = league_car
    return(league_entry.save and league_car.save)
  end
  
  def unregister_driver(user)
    rec = self.league_entries.where(:user_id => user).first
    league_car = rec.league_car
    if !league_car.amount.nil?
      league_car.used_amount -= 1
      rec.destroy and league_car.save
    else
      rec.destroy and league_car.destroy
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
