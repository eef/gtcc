class LeagueEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  belongs_to :car_class
  belongs_to :league_car
  has_one :standing, :dependent => :destroy
  
  after_create :generate_standing
  
  def generate_standing
    if league.standings.where(:user_id => self.user_id).blank?
      standing = Standing.new
      standing.user = self.user
      standing.league = self.league
      standing.points = 0
      standing.car_class = self.car_class unless self.car_class.blank?
      standing.league_entry_id = self.id
      standing.save
    end
  end
  
end
