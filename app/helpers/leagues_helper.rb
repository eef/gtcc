module LeaguesHelper
  
  def next_race(item)
    race_link_text = ""
    case item
    when Race
      race = item
      url = race
    when League
      if item.races.blank?
        return("No races scheduled")
      else
        race = item.races.where('races.start_time > NOW()').first
        url = "/leagues/#{item.id}#races"
      end
    end
    race_link_text << race.start_time.strftime("%d/%m/%y %I:%M%p ")
    race_link_text << ActiveSupport::TimeZone.zones_map[race.timezone].to_s
    race_link_text << " at #{race.track.name}"
    return(link_to("Info", "#", :class => "ui-icon ui-icon-transferthick-e-w has-tip convert-local race-time", :title => "Convert to local time", :style => "margin-right: 5px; float: left;", "data-time-id" => "race-time-#{race.id}", "data-local-time" => local_timezone(race), "data-race-time" => race_link_text) + link_to(race_link_text, url, :class => "has-tip", :title => "Laps: #{race.laps}", :id => "race-time-#{race.id}"))
  end
  
  def local_timezone(race)
    str = ""
    race_timezone = ActiveSupport::TimeZone.new(race.timezone)
    user_timezone = ActiveSupport::TimeZone.new(current_user.timezone)
    race_utc_time = race_timezone.local_to_utc(race.start_time)
    str << user_timezone.utc_to_local(race_utc_time).strftime("%d/%m/%y %I:%M%p ")
    str << user_timezone.to_s
    str << " at #{race.track.name}"
    str
  end
  
end
