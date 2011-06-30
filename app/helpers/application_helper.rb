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
  
end
