module ApplicationHelper
  
  def note(text)
    content_tag(:span, text, :class => "form-note")
  end
  
  def tooltip(object)
    case object
    when Race
      render :partial => "raceinfo_tooltip", :locals => {:race => object}
    when League
      render :partial => "leagueinfo_tooltip", :locals => {:league => object}
    end
  end
  
  def reg_car_name
    if @reg_cars.nil? and @classes
      text_field_tag("car_name", "", :class => "text-input autocomplete") + select_tag("car_class_id", options_for_select(@classes.map {|cc| ["#{cc.name}", cc.id] }, {:id => "test"}))
    elsif @reg_cars.blank?
      text_field_tag "car_name", "", :class => "text-input autocomplete"
    elsif @classes.nil? and !@reg_cars.blank?
      select_tag "league_car_id", options_for_select(@reg_cars.map {|cc| ["#{cc.car_name}", cc.id] }, {:id => "test"})
    elsif @reg_cars.first.car_class.nil?
      select_tag "league_car_id", options_for_select(@reg_cars.map {|cc| ["#{cc.car_name}", cc.id] }, {:id => "test"})
    else
      select_tag "league_car_id", options_for_select(@reg_cars.map {|cc| ["#{cc.car_name} - #{cc.car_class.name}", cc.id] }, {:id => "test"})
    end
  end
  
  def google_analytics
    s = ""
    if !Rails.env.production?
      s = "<script type=\"text/javascript\">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-11698155-10']);
        _gaq.push(['_trackPageview']);

        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

      </script>"
    end
    s
  end
  
end
