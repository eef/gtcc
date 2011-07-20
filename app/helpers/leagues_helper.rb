module LeaguesHelper
  
  def next_race(league)
    race_link_text = ""
    if league.races.blank?
      race_link_text << "No races scheduled"
    else
      next_race = league.races.where('races.start_time > NOW()').first
      race_link_text << next_race.start_time.strftime("%d/%m/%y %I:%M%p ")
      race_link_text << ActiveSupport::TimeZone.zones_map[next_race.timezone].to_s
      race_link_text << " at #{next_race.track.name}"
    end
    link_to race_link_text, "/leagues/#{league.id}#races", :class => "has-tip", :title => local_timezone(next_race)
  end
  
  def local_timezone(race)
    str = ""
    str << current_user.timezone
    str << ":::"
    str << ActiveSupport::TimeZone.zones_map[race.timezone].class.to_s
  end
  
end
