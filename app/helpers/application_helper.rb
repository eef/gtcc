module ApplicationHelper
  
  def note(text)
    content_tag(:span, text, :class => "form-note")
  end
  
end
