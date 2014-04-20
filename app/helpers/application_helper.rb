module ApplicationHelper

  def markdown(text)
    # options = [:hard_wrap, :filter_html, :autolink]
    markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML
    markdown.render(text).html_safe
    text
  end

  def html5_shiv
    "<!--[if lt IE 9]>
      #{javascript_include_tag 'html5'}
    <![endif]-->"
  end

  def mixpanel_track(event)
    "mixpanel.track('#{event}')".html_safe
  end

  def mixpanel_track_links(link, link_name)
    "mixpanel.track_links('#{link}', '#{link_name}')".html_safe
  end

  def edit_path(resource)
    eval("edit_admin_#{resource.class.name.downcase}_path(resource)")
  end

  def delete_path(resource)
    eval("admin_#{resource.class.name.downcase}_path(resource)")
  end

end
