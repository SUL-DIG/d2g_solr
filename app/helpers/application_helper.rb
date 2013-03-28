module ApplicationHelper

  def on_scrollspy_page?
    on_about_pages
  end

  def params_for_session(session)
    {:f => {:session_date_sim => [session]}}
  end

  
   def render_external_link args, results = Array.new
		text = args[:document].get(blacklight_config.show_fields[args[:field]][:text])
        url = args[:document].get(args[:field])
        link_text = 'Find This in SearchWorks'
        results << link_to(link_text, url, { :target => "_blank" }).html_safe
  end

end
