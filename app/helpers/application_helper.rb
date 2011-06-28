module ApplicationHelper
  
  def note(text)
    content_tag(:span, text, :class => "form-note")
  end
  
  def tooltip(object)
    if object.class.eql?(Race)
      render :partial => "raceinfo_tooltip", :locals => {:race => object}
    end
  end
  
end
