module LeaguesHelper
  
  def next_race(item)
    race_link_text = ""
    case item
    when Race
      n_race = item
      url = n_race
    when League
      if item.races.blank?
        return("No races scheduled")
      else
        item.races.order('races.start_time DESC').each do |race|
          if race.results.blank?
            n_race = race
          end
        end
        url = "/leagues/#{item.id}#races"
      end
    end
    race_link_text << n_race.start_time.strftime("%d/%m/%y %I:%M%p ")
    race_link_text << ActiveSupport::TimeZone.zones_map[n_race.timezone].to_s
    race_link_text << " at #{n_race.track.name}"
    if n_race.start_time < Time.now
      title = "Click to view results"
    else
      title = "Laps: #{n_race.laps}"
    end
    psn = ""
    if n_race.results.blank?
      unless n_race.psn_race_id.blank?
        psn << "PSN Race ID: "
        psn << n_race.psn_race_id.to_s
      end
    end
    return(link_to("Info", "#", :class => "ui-icon ui-icon-transferthick-e-w has-tip convert-local race-time", :title => "Convert to local time", :style => "margin-right: 5px; float: left;", "data-time-id" => "race-time-#{n_race.id}", "data-local-time" => local_timezone(n_race), "data-race-time" => race_link_text) + link_to(race_link_text, url, :class => "has-tip race-time-#{n_race.id}", :title => title) + "<br />#{psn}".html_safe)
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
