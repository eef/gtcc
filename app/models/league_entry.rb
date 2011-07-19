class LeagueEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :league
  belongs_to :car_class
  belongs_to :league_car
  
  after_create :generate_standing
  
  def generate_standing
    ap self.league
    # unless self.league.standings.length > 0
    #   self.league.league_entries.each do |entry|
    #     standing = Standing.new(:points => 0)
    #     standing.league = self.league
    #     standing.user = entry.user
    #     standing.car_class_id = entry.car_class_id unless entry.car_class.blank?
    #     standing.save
    #     logger.info "Created standing for #{entry.user.username}" 
    #   end
    # end
  end
  
end
