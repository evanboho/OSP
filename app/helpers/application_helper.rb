module ApplicationHelper
  
  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink]
    Redcarpet.new(text, *options).to_html.html_safe
  end
  
  def mixpanel_track(event)
    "mixpanel.track('#{event}')".html_safe
  end
  
  def mixpanel_track_links(link, link_name)
    "mixpanel.track_links('#{link}', '#{link_name}')".html_safe
  end
  
end
